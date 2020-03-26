Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F1C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4992078E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="0cQ3XaBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCZJGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:06:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39162 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCZJGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:06:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so5561961ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ftyrJKWHrnqxmAMnMD5xUJzM/G97V4BddosbLSBGTzA=;
        b=0cQ3XaBpmCnfMXdocLzBOA7ESTA0ysdWDc8iN1hesExYsZDG9V3QrZxnNblDXjyMMc
         Vg4/vRhrtj3ZcOJ8Qi42C1SVw2I63U5qQyr5CN+h262A+E3ikdDJFd9bmCXXe6Y2I16t
         ld2+aEO2TQZDLSggZVRpT6A0oQFwm1yCHawIb6N6UknZhfHsaKL7xZwGtJnW9oqPzu//
         dSF8KieDo75QMH4hthiryIFeeI3QcrUeoC0J+sfnDKVd5kFN2RE9sU+ORcGRwszmz5nN
         D4CTHtxLQnLtioNtR/VWfIHDgzE4H2cxjIahLmQiJjsW0SJxNznycN44Bk8qrOIj0fvn
         nHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ftyrJKWHrnqxmAMnMD5xUJzM/G97V4BddosbLSBGTzA=;
        b=V+J2j/xQsDokV2SndPAjMe3C18ToI2wNtMM9yHSRSHa/IBEzipAJrIU2Rwak3nezlc
         yEKAer3xfXJUy78VUAVWXMyL/JTwdD0XQcYValx4Kz2EHigAB7fpLX+3iOPIR9Igxu6K
         Jamj0SFTAFpRBSuIFTglnisRqjTKHiED+qP4HKYZO/yEkLWQhMtKObSzqAFwivmRVGws
         DQubXzMMJyiXbObYWWqniK7EAlwC6tomz/kCQNxyr2C2P+eI8PtEGlxOsPdS3CuA+DWY
         tNnlfedjBZL5LZQr9QrFfzkj7c2BGdWqnZm1IsOypNZLy6l/CW2omJha6OJgB82hebuI
         5HHg==
X-Gm-Message-State: AGi0PuZ5kWNa+5xwMReBYm7ERYybNInmxijpBk/W/njW7tlhLUErN61K
        70w2/g4JbDYTag9T6vXzV0ERQ7FqZ7PEBQ==
X-Google-Smtp-Source: APiQypIpD/3riGpWEgV3QZX4cYJsaL9WE087URORtHPmNzjLTGFNdbyQZH8aaP4yboWJ1qd4cakXlA==
X-Received: by 2002:a2e:98c3:: with SMTP id s3mr136339ljj.6.1585213571692;
        Thu, 26 Mar 2020 02:06:11 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:6b6:227a:19e2:766d:df47:72fb? ([2a00:1fa0:6b6:227a:19e2:766d:df47:72fb])
        by smtp.gmail.com with ESMTPSA id d23sm1044004lji.62.2020.03.26.02.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 02:06:11 -0700 (PDT)
Subject: Re: [linux-next PATCH] ata: sata_fsl: fix a compile error
To:     Li Yang <leoyang.li@nxp.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200325235921.22431-1-leoyang.li@nxp.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7dda967d-4328-abd1-2687-95bc213030dc@cogentembedded.com>
Date:   Thu, 26 Mar 2020 12:06:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325235921.22431-1-leoyang.li@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 26.03.2020 2:59, Li Yang wrote:

> drivers/ata/sata_fsl.c: In function 'sata_fsl_init_controller':
> drivers/ata/sata_fsl.c:1365:15: error: 'ap' undeclared (first use in this function)
>    ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
 >                 ^

    Another fix has been posted yesterday.

> Fixes: b3f06231 ("sata_fsl: move DPRINTK to ata debugging")

    12 digits SHA1 is needed here.

> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
[...]

MBR, Sergei
