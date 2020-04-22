Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C22C5518E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1481A2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vxrw4X12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDVQq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgDVQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:46:26 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A12C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:46:24 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i16so2562004ils.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cV4OuPmkRZ6+zxhfjx8VUKHzAPPELWDKUnr+i1Zl2E=;
        b=vxrw4X12UbXuE8+hKgIRfqbehXZCbT3g1S5XxQ+LVjc5pBkTlst1hlpCAKpWhhZuRu
         veFMvmN+TdYJoobKQlAcPw6JABkRX/KE0oY7sokc0O3Ubt/H9HZmiPyMcH7mA95pj6Mv
         hsbcYkcLl9TIpZJkeOuziDN9U6KahUNlKAIvHBxipbOf4/3GY6HNpcM5h/0atEYHfS1J
         5TnA8z0aXlRNGp/PDhj068qQJeSm366/rYglsOfDgkjlAbyg23I3BhZcaQGv49KdWiYT
         nagOCmHMaULGJBLasMsxEUo6OJAP6KBFFCvGx1AX1CdYZDUtp8pnaisywCFpPZkRJfya
         i9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cV4OuPmkRZ6+zxhfjx8VUKHzAPPELWDKUnr+i1Zl2E=;
        b=ePuG8Q++ltbEjPfzaPEaLhvlN1RAw2lwiwhIMyJINth4zsi8h6OIQfgO+33p7atLah
         FNDGCHC3yphjnvF0EBBMRXZkuFnr1Kdo1owG7k7og8M6dIquGKkDRGxeUCNUKbWPu/NP
         jGhRU6TCzei+6YyqR3iUAji7/qamk2hyw3HD1EDRW8puRp3U7hVZm2VwZPljeTRhNSlG
         IrmdIoJw6H/bpC5HkG1Ee13Lduu2wyI7XClDw2Z/P+5ZJpmu656Q8lDjRBuNTVv9yKy+
         t7Z7vz+k88aQDsh9mcmvmwv4PAG4xcp75GLVE2e+FJm2Ce95QXA0IDfMj2QWJuyjlWDz
         0gaA==
X-Gm-Message-State: AGi0PuYO8EymmMf3xcieakD0yIrjbjJ3XdWMooQ+5Cv6SgqPu1hpYkhK
        X0VsLGQGmJw6xBvpS+Iagp77VA==
X-Google-Smtp-Source: APiQypIBWtVOQSTuiObuI0NSKLZhoSwUm3Bnp61Fd89wZTmPr1Njs/VncynYhJfgmsOlad6tANPNUA==
X-Received: by 2002:a92:cece:: with SMTP id z14mr26155375ilq.147.1587573983733;
        Wed, 22 Apr 2020 09:46:23 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c18sm2251436ilr.37.2020.04.22.09.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 09:46:23 -0700 (PDT)
Subject: Re: clean up DMA draining
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20200414074225.332324-1-hch@lst.de>
 <20200422064151.GA23271@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f969685b-6547-2e93-f288-d2b1d5ec4dc4@kernel.dk>
Date:   Wed, 22 Apr 2020 10:46:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422064151.GA23271@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 12:41 AM, Christoph Hellwig wrote:
> On Tue, Apr 14, 2020 at 09:42:20AM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> currently the dma draining and alignining specific to ATA CDROMs
>> and the UFS driver has its ugly hooks in core block code.  Move
>> this out into the scsi and ide drivers instead.
> 
> Any commens?

Looks OK to me, and I think the idea is sound.


-- 
Jens Axboe

