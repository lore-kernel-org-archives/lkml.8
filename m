Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845F8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A2B2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dykUl5Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgGFNer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:47 -0400
Received: from mout.web.de ([212.227.17.11]:47009 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgGFNen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594042443;
        bh=zyikPEHRSl6AfWnrIJsptm0zk3698RDADIrgUvP6JL4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dykUl5Z/jkWGSiBqMz4YjIFMzhj+0rJ2OaWEPiEAI/j5AfTD1SwZFV1ngl4I5f6DO
         fijeLzd/p3DfhXKJkRQvhkv+isL05Ej0ziAXBthUrNufqYBB/WWo6wwmf1fWJTqATk
         cYlILoX2ryhGkRtx0jITSpMnqpQpvbZEDDZTmaq0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.113.119]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDxCN-1k85vJ4AkJ-00HOMY; Mon, 06
 Jul 2020 15:34:03 +0200
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
To:     Hillf Danton <hdanton@sina.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
References: <20200706104915.11460-1-hdanton@sina.com>
 <20200706124241.4392-1-hdanton@sina.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7ed25c44-bb51-2d8d-82d9-f11272f56424@web.de>
Date:   Mon, 6 Jul 2020 15:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706124241.4392-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQRlprojWG/gbX7gfH4IvEPq/yWggqojlOSRndeRHXRFyV6gflb
 3xWgaDC2zU027iUUZvbgo88UWGbzSIKD1b6S9AvXbVA8CeL2Azt1uZ6fGcKlDfKdy55quTE
 cR+Mt+yHCVh8apr9KJGjIMgZJ81TahgojBeJcPw65TliQU1reY7BHvAV2cKvE9ISZVV9TD3
 mmKhR5yHSmjdIY3H8yxjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bc4I7rzFw7Y=:cNVHiMPx6Tz5XJ2v2Fet5L
 WPSOVTbpBAx5uuo8/zhhlc01QKoJzuLXGC5tm7GTsqLsqF6Wt09RES/ga7QxdZFRnPt0aFAIz
 3zLqiQAp9V7FZSYx6pDzbhdT+j9Wqjr5NY0HvJsmQxaiKNAGvcdT9pSBjmWozz3G3extGph9I
 BGpdf97jPf7BdR/w7t7l8KjaPMm9goumyruTzQAs+kLIUt1jhpxtLcRxOTO9oEZqC0gqDoyfb
 6s/fiYsSBXIX+8EKmroKYlI+JjAMxQfm5bZ/kcNck7EJuT5TBMT9L3RbBwiaxn5yDg9uXsrRe
 N7/6G6A8QNsw+bbZHejh+b1aAaHA5boGwT1hEMnMj2zi0G1SS/vE55HF/UsIYdynSGdKe+ksL
 +Jq73DwtM/9cbsrDHu/pW9WgI23InPXZqLaSGKBGBefhLOof//8shNiSnBhvmAltY5A06u1Z0
 XuyCoTNig4322Y3ZI/zqNO1tWLlCsDXNjrZSLPvzYrVNMQ5I7XH89ODiYgZBUrfEFOCHaJCS2
 thHyPSx1XF6w+zqUGXAMHJY/vGOh2a89sVrlsXIcvZm0MvEa4BaJ+1A175S51nkcxSdgdpx0s
 IX0lY/CF/mpfQO1DifuCravqMPX6w/NV3nRPGG3dw3jUD9TDKrz2o67R7e7zZTBUOKtfnqvFy
 EBqjodHKBN6PiWihbfekk+kgsu9j9olhWiRTCBC9FHGO004FfnqBcw6I0uUJvZVWP06USeqY/
 d2RNleTGOxan7MtsOJZSeVWA6j8UC26b4Nrwz3Pl970LLoQmhsCkvn7T2GSKw0FhchAwx3FIG
 S01GqDhvvW/c0Gi5GxGCifx75z0MTvpv2kJGda7EgmOnJkdC4Zc8zarKGicsgY8qZniU65+Dh
 aVZUimK5ogOuWpOkaKvBPXb4xJr2f6J51lGDy5PzwqEpD8TDY4nynfvc2GRDTxtwYJazuwXov
 H8qtq2wbzcBeA2k+mta2Wa2Pep6tuBf0SLArTxho3N/XireqaYZAEQUyTrsgj9h5zh6i4yEOg
 sv+n1Em1NRa/BVDBQIrEhrc2UVI/qowXwI7ocjOeEHpklgX7k3fYyZOG2CZHenUJZIgd0qJcx
 Jyl4p+DEu/ZA7y8NwFnSjz+ckFRw9QcyuWSSqQH2EFMhXW0hbHyu9g/GCUCzoLftX9gPHTHW4
 75ItyfO5X7Egz9+QRliWT6qhP5QXWHNHtS+4AQT/fSrmBNyCBT54B5wQhqNPTZz8eTMol0cLN
 cGWL2wYTGPTO7DVuz8ES+C7IveaDdFdjxiYNqhw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can it be helpful to convert initialisations for these variables
>> into later assignments?
>
> Perhaps. Then it looks like the below.


=E2=80=A6
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2798,9 +2798,12 @@ static int vfio_iommu_type1_dma_rw_chunk
=E2=80=A6
> -	bool kthread =3D current->mm =3D=3D NULL;
> +	bool kthread;
> +	bool use_mm;

I would prefer the following variable declarations then.

+	bool kthread, use_mm;


>  	size_t offset;
>
> +	kthread =3D current->flags & PF_KTHREAD;
> +	use_mm =3D current->mm =3D=3D NULL;

I propose to move such assignments directly before the corresponding check=
.


=E2=80=A6
>  	if (!mm)
>  		return -EPERM;


+	kthread =3D current->flags & PF_KTHREAD;
+	use_mm =3D !current->mm;

> -	if (kthread)
> +	if (kthread && use_mm)
>  		kthread_use_mm(mm);
=E2=80=A6

Regards,
Markus
