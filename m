Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5E9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B591F2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmYmHmxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgGMIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgGMIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:09:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966EEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:09:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so14818446wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=goZFdv0vYFu2qS+8tgZEgkamqnIThorE/kvTLGKqcjg=;
        b=OmYmHmxuhJhhhadcUjIexz8FybS0Qab1l5YUvnTcwlHRlfPb3o6CxYT7D3lPOTgSY1
         W/KjDgtKjNd/47TU74VaF4LA9NfwpYM5/nEIC1kC5YP70Mu8PQZCF1LEhvccq8evwrSr
         UnGRC0q/pmBw7NVdGDYVD4UOwaGXq/jCDodj/+l5uwYWx6bXOUuNzkbajhL+dOOf4ua9
         gJjnXtXfjCCfqYyQ6Jx7rzHyBO55DdJqT5suU4H/8lYqjJGxnsrlKc6DT/8Cbc7jHSRF
         ccsevynM3q1ZfxqS1eUCWCsljRbbZrAxiyCYmULL3DddmEmI62Li4GgR+JFl3k8VT3oA
         49Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :content-language:thread-index;
        bh=goZFdv0vYFu2qS+8tgZEgkamqnIThorE/kvTLGKqcjg=;
        b=VlP2QWaSnbi6/zmNP8MtnkZTeYXtfeBsQawkhAWBF+OJFymOSMDXCwezReHB+1q2si
         atd+DZhyKbp1Ut9yv70w91mCux5E9q4R3Kz1Aib1t5wZvxNmoek82LoJul1c2ceYxkuG
         nmI+z1gpBZFXqd2spuHbbtvOqWomabeY1YhmbmzDUh4Q78LC/6M4qY+J7HCoW3uraRUc
         y9d6pMXSyr6ssZ74T/iCflgXFrjxndAOfCcmACTCN4zLT5ftjTnPEMBN0+n2lcB8SbWO
         aIcs6d9xyhesYtZp83zNtLwjtypJRqc1txhYROvR92wmJsUc8M2DEJ+wkGRzmiPmuObU
         /epQ==
X-Gm-Message-State: AOAM533oNQqDOkI8WH/9G3QCuak62UDbUh/WRCQNLO0wR40E2G5Cl/mK
        30Nm8FrLtM55dHS9d8wNQxk=
X-Google-Smtp-Source: ABdhPJyr5gyI63fyswQfNkAN5vUdZgX+iXjJYkUAcBLa26UIsUoR2kkPYeok06gmIYfdASjUIA1utg==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr79156106wrr.266.1594627750240;
        Mon, 13 Jul 2020 01:09:10 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id j6sm23357762wro.25.2020.07.13.01.09.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 01:09:09 -0700 (PDT)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
Reply-To: <paul@xen.org>
To:     "'Souptick Joarder'" <jrdr.linux@gmail.com>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
Cc:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        "'John Hubbard'" <jhubbard@nvidia.com>,
        "'Paul Durrant'" <xadimgnik@gmail.com>
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com> <1594525195-28345-3-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1594525195-28345-3-git-send-email-jrdr.linux@gmail.com>
Subject: RE: [PATCH v3 2/3] xen/privcmd: Mark pages as dirty
Date:   Mon, 13 Jul 2020 09:09:08 +0100
Message-ID: <003901d658ec$e2d93460$a88b9d20$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQGQUUjbM0hB7euxJ1kpRMo6FNfk+gF2cfqiqYWDhTA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Souptick Joarder <jrdr.linux@gmail.com>
> Sent: 12 July 2020 04:40
> To: boris.ostrovsky@oracle.com; jgross@suse.com; sstabellini@kernel.org
> Cc: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org; Souptick Joarder
> <jrdr.linux@gmail.com>; John Hubbard <jhubbard@nvidia.com>; Paul Durrant <xadimgnik@gmail.com>
> Subject: [PATCH v3 2/3] xen/privcmd: Mark pages as dirty
> 
> pages need to be marked as dirty before unpinned it in
> unlock_pages() which was oversight. This is fixed now.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Paul Durrant <xadimgnik@gmail.com>

Reviewed-by: Paul Durrant <paul@xen.org>

> ---
>  drivers/xen/privcmd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index b001673..079d35b 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -611,8 +611,11 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
>  {
>  	unsigned int i;
> 
> -	for (i = 0; i < nr_pages; i++)
> +	for (i = 0; i < nr_pages; i++) {
> +		if (!PageDirty(pages[i]))
> +			set_page_dirty_lock(pages[i]);
>  		put_page(pages[i]);
> +	}
>  }
> 
>  static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
> --
> 1.9.1


