Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D6B208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdgV3wv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGDNdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDNdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 09:33:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64FC061794;
        Sat,  4 Jul 2020 06:33:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so35662593wrn.3;
        Sat, 04 Jul 2020 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=0aUfXSg0arZGZKHdkJrpGOCQDAyLG7wmioIxcwMAyxM=;
        b=SdgV3wv0ScOuelLJmjQxFQhn1lIRRiktglhLerZhhRYqL/tTxI6eYsLM8MXM4DuqDN
         Ah/0AVQL7osE2lF74X93Rv2L/1FNt3aeUY+s06TEMsCXRbk8REC3mk+WP/veVdpq7/d0
         Vn3k8X8h//RlKM0Jhyg6X8TfNN2ANC6lfqdLKOlcOxm7FEX5zkpvF0bOYgZY0DFHzbED
         mcIxZortfF1Y44xXDvdZvmADv1vz1rstcmaP1aEx8bdOewL7E/qUuvS45xvfyTS2sR+V
         6v+FvdTPz15nOVHqsHy2GyEWMmys1TTk45p394TsXgMu4cep1prh4KQ6HIHz5NS0DjTC
         L9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=0aUfXSg0arZGZKHdkJrpGOCQDAyLG7wmioIxcwMAyxM=;
        b=iLSc0brBB13MM5eyWb7DoqsbFKdWw0GRr/t/8I10ytV6I2af7nIjfTwmoazkx3Jlqe
         newxf2mMS371iyhKMoBjWFLoUUh2EfhLYOWJi8Ponc6+siLUS3g72PP73Rd4Lqvw5CuD
         m5y34vg2qmnWOYVOwBVzM+ts8sh08GiCMUhphsxeuLQ5D79tPu8T3Q4gp2SCz/xocDZ7
         xIKmtqDYoQfHRxgwuh+EWLZFacx5U/aZYrxHM/C/7ioOPEG3XQybX1jd+8blNWnnyF1l
         8dEyFp2OK2u++F/szRyMRM7cDOe9/MuJOFa3fM0YJ4LXC8kj2g4auLb3DqBP9yo7qCVz
         Gv7Q==
X-Gm-Message-State: AOAM533Nkxf6CxbpfVENkyvPua5u4XKRoB+PjF0JB5/rwKExAOfwBNFe
        jeZ8XnkmfEyyKEB5yBxOTErHwOPMrqw=
X-Google-Smtp-Source: ABdhPJy754Y72mstvVjug3N3ZrLOsxRHrDZhOujfHBx/qdK++rzuLVOgEp0B7FaL1FkeGiu/ZSxBkQ==
X-Received: by 2002:adf:e944:: with SMTP id m4mr41804071wrn.252.1593869620501;
        Sat, 04 Jul 2020 06:33:40 -0700 (PDT)
Received: from [46.117.43.200] (46-117-43-200.bb.netvision.net.il. [46.117.43.200])
        by smtp.gmail.com with ESMTPSA id q7sm18235625wrs.27.2020.07.04.06.33.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 04 Jul 2020 06:33:39 -0700 (PDT)
Message-ID: <5F00850C.6010803@gmail.com>
Date:   Sat, 04 Jul 2020 16:33:00 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 17/17] Documentation/driver-api: xillybus: drop doubled
 word
References: <20200704034502.17199-1-rdunlap@infradead.org> <20200704034502.17199-18-rdunlap@infradead.org>
In-Reply-To: <20200704034502.17199-18-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Eli Billauer <eli.billauer@gmail.com>

On 04/07/20 06:45, Randy Dunlap wrote:
> Drop the doubled word "the".
>
> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>
> Cc: Jonathan Corbet<corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Eli Billauer<eli.billauer@gmail.com>
> ---
>   Documentation/driver-api/xillybus.rst |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20200701.orig/Documentation/driver-api/xillybus.rst
> +++ linux-next-20200701/Documentation/driver-api/xillybus.rst
> @@ -273,7 +273,7 @@ buffer is full, the FPGA informs the hos
>   XILLYMSG_OPCODE_RELEASEBUF message channel 0 and sending an interrupt if
>   necessary). The host responds by making the data available for reading through
>   the character device. When all data has been read, the host writes on the
> -the FPGA's buffer control register, allowing the buffer's overwriting. Flow
> +FPGA's buffer control register, allowing the buffer's overwriting. Flow
>   control mechanisms exist on both sides to prevent underflows and overflows.
>
>   This is not good enough for creating a TCP/IP-like stream: If the data flow
>
>    

