Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 11:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0094A20663
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 11:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MgUvTfyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgFFLVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 07:21:55 -0400
Received: from mout.web.de ([212.227.15.3]:41925 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgFFLVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 07:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591442504;
        bh=PvdB1jlig5gPjk+E7qkJrOtVJDGK6YtwTQrAFwVDAOc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MgUvTfyidmi8txwizqxSxAENby0jq3hyXjH2GzmoNdZxZSVHEGtlS+BP34cKNBJqd
         UmpTbPHWV32YQk2PMvNpYgQNiXY9NRj+fKYYCCoggHDgQcmhTqZQWW49mAklF07/Cz
         U1BjA4q9wohMhUDNwzdtKrHjDbDcEIT5sOoH68X8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Luu81-1izIF720av-0103Qa; Sat, 06
 Jun 2020 13:21:44 +0200
Subject: Re: coccinelle: api: add kvfree script
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <99ed463c-b7ba-0400-7cf7-5bcc1992baef@web.de>
 <alpine.DEB.2.21.2006060944320.2578@hadrien>
 <51a176d4-8c59-5da1-b4d2-c97b17b691a7@web.de>
 <alpine.DEB.2.21.2006061307020.2578@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bf698c44-4384-e471-3ff0-e38587140b98@web.de>
Date:   Sat, 6 Jun 2020 13:21:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006061307020.2578@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:cyWwJjQSkVzLGnBAQuoHWGcniaoteW35rJSoEbMM0j+hrQOr7mn
 HdsPmERCSi+Mr4MSxVJB2wBGCuvz2QHlcN8uUTTiWGhNMP0wm8rScctq04LA0NOQFHB/wfW
 Do2M6QF2Vm7AMr89e3uI91Ujn0F7612DFQoA+Gs8cPnzm4XbSgtGfA6V+aaNtVEaj3bIKD8
 aUYvcmISXdKkL8WPUxKxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0appR+Bq6A=:vpbi3TTa9+syRiX1gqs84W
 byzk4x6JHDfwzYZUdALzIvZcnK4tALCh9jwQm+Ed774lv5ZLAYe8mO+NXt7FLUQG1cvCR+7PQ
 XkkRPVQvmKCaD+BV3ATWMgXxiBw9BJETGi22g6ZSVG4h/UX8xx2Zat6b2difGZXzg5VAQ266g
 jW5NXEPjibPa8hZnUssVHdaxlXuZ00eHbF9djCvrg+usmNxSQ/VeoVXI4rnGLrmBwz4tgCT0z
 ofv8KSIKk8uk02aJUuF1WOBny0/mXATyPdTThIJUgK9MnzC8YUWRCNGWnknSIqVP3RmmREO/Y
 Cih+4+2FTEY5FbVrsq7n+6KGAaLRKniNQPF5sq4WCbD6Y16danAfMnFHpmt9f5ExQIRbkzpC+
 HOsgfmrN6Y1CqopBh1bCr2SmOi4zcwy/yoUj3zkWpG1qWMfWwyWU1ixTOI4SzUw6VFNf3VU09
 rW/0+IUCF8hm+GOu93NuknMBHemor9F+4FUANi6Yr9FFzqetdaABaz0B+zrN3tZlDp9+Ydb2Z
 2CXDb/L8qRy89ezWSv/RO0V17Wekbi8WAmQB4sWNp88Es5Ueta23HtqopPoQPG2gT7CTH8MKj
 5LE3im7oNabDD30qJvjgD2nvzCFDTV6L0YO7fUL0hXn3djOonc2pfISH5n15VM8Zt4uRk2+Dx
 o0hhdfolDiE/AtrBDSQ2DdTROws4M2WhHr7tjCW2LwjEuNBoB42Eb5BnypmKiDKpWhnVrXGho
 +Au0FIOZZswuDBGHRYIkCt50Uuo3YRxkWGSRkHzEink7TIFWDO6MCO60aXLiSo062hVjau6OM
 uLEkCowNbR8c0M7JzKYrvjm7GwHzew5PAaA5NLThUI6VFjsj91sH3uIU63nNYmT96HL6AVjKY
 dHMrST740UvrP9q7i4KI9QGirpj9xQBvKniqHB8s7b19bTJmKTdACEK0YVEzWx48ARkb+V/eH
 JbLeWxd1Lh3sXwS/zrr1vzQlaEMVxZ+fH2pvGBCFr9Ttqzkd0i7VSovhSsTziT7zLWRQVrMqT
 07WwRptqnV1tZeFd1olRUwM8StKkC60Ddd/tVCVhORcsGuZ8y5Fhz3xUgh4/9onVqsICJV84y
 Mxyip/vA5vFo6eyN1Sr+kpXi4h2H+ZU00xr9bVofV+PEAd9icG4vDYefTCX2Dz4R9GKOVUp6y
 vAYmLr5COw2Y7EZio+gbFaysTkq9kGBWV3F+BVOvECNE4VJk8T2dv76C5zmpabTlEA7v2v1b/
 Mo2m1MoQDDMi1E7Ky
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So there are a lot of reasons why constraints are useful.

Thanks for such a view.

Thus I dare to point the possibility out to consider their application
for mentioned function name lists (besides using SmPL disjunctions).
Can coding style concerns be resolved in a more constructive way then?


> But hiding information that could be apparent to the SmPL compiler
> and could be used to improve the performance of the matching
> process is not one of them.

Will any software extensions become possible also in this area?

Regards,
Markus
