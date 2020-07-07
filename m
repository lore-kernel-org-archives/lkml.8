Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE93206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastree3d-com.20150623.gappssmtp.com header.i=@fastree3d-com.20150623.gappssmtp.com header.b="QYe04Gp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGGJzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:55:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5ABC08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 02:55:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dm19so31602533edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/Ez/eNUFPCT1S8lswjEFBXmdJUzvT2sdIqH6wPm0/aY=;
        b=QYe04Gp38RAEy6yPyNS14pK+XfQocLSDgJ5LEkRhAj7ABmY3kR3xx8qgc+u4Ry9uLZ
         k7KwDZbKVUaqCo7UyJxkZneDWHjo4VIi7Myp8O0I5c2pu5SepM0Fi0OuDMrFOvYOQ0zT
         MgkmuHp7x/wQGhMI/BKXWZyEgvQkHoZv5AWHVx3EeycrVCA6X3+sxTqWjP31srbxOqA5
         yVtGbKBN4350Uuy3yZI1ZWcplnWdk0fBAZZ0ITq45nji+j8YX8rbkBvosF9UiyRasryu
         hUST3Iy0F6nQyiIDl+ApwQ9pnqe7sV14ch5qEgADgY8wf41L455jHEpu1Dsym4MX3hrF
         AZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/Ez/eNUFPCT1S8lswjEFBXmdJUzvT2sdIqH6wPm0/aY=;
        b=MRKb6rHGtNE1BmT0HYv6eq3GE/qN77mHWRQQIKlbF8vcAIfLGfUQpXZHRsE2juFPKy
         qt6u3/bCWVPudo95dupJ6FkxrE0/o2YUDJvDnmsTsQ5IfVvCGylXauxk507vGwHnHWH0
         DZOo3URHGhsaBi1OhCQzm3yq7U8O6Ma3LA3S/aTd6YXjoKyxqb0EivJQZcL6WZybkRMQ
         eQGiNg/smMBOy/BnT5LYJb2jS2vpc7GHBeDA21BaFo+fErIM84HJLg1VQhb3ngpBI3DK
         T0EAq4OCsNkzhxc1IbWfjUEJ6KT2hLL6Wo0eYH5TWGZQyP3ukvyppAmKFv9MU39J4cg9
         FfpQ==
X-Gm-Message-State: AOAM532NMi+n9xkD0kexDxfuelzAhkPORMrpDk/jYWWXSZlf2Pv+31o1
        R1t5KR4nhCj9hpBD0VfqHWsOhGteKA==
X-Google-Smtp-Source: ABdhPJzYEcxxIS7vSz9rt0N2e7MfND9YJ80TBhiJ+JQGtUro+WBaNmFEN1hYulHOJD1yWqfwad40/A==
X-Received: by 2002:aa7:d50d:: with SMTP id y13mr60181703edq.230.1594115749762;
        Tue, 07 Jul 2020 02:55:49 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id z22sm25865328edx.72.2020.07.07.02.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 02:55:49 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Add documentation for SPI daisy chain
 driver.
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706092247.20740-2-adrian.fiergolski@fastree3d.com>
 <CAMuHMdW_aTKtrUnGqf3DB=fr0ZxTsjoEjMmwSpPqhwjs-Tz7ig@mail.gmail.com>
 <d80b1b85-ee23-3244-9bb0-876986f6ff17@fastree3d.com>
 <CAMuHMdUV_2DbbUqp+0=XARyLCwPya1RqFCrr6VoTJjVAZiKJzg@mail.gmail.com>
 <20200706162246.GC6176@sirena.org.uk>
Message-ID: <853fa4a4-ce2f-0503-2fe7-7b34b352b6e2@fastree3d.com>
Date:   Tue, 7 Jul 2020 11:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706162246.GC6176@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert and Mark,

Thank you for your comments. I will try to address them in the next replies.

On 06.07.2020 18:22, Mark Brown wrote:
> On Mon, Jul 06, 2020 at 05:32:51PM +0200, Geert Uytterhoeven wrote:
>
>> However, that information would need to be added to each driver only once.
>> With your proposal, it has to be added to all affected nodes of all DTSes
>> of all users.
> Right, these are fixed properties of the silicon which we know simply
> from knowing which device we have - there is no need to put them in DT
> at all.

I see. I agree with you. My concern was just the lack of compatibility
with the existing drivers. I will try to add daisy_chain information to
spi_driver struct in version v3 of the patch.

