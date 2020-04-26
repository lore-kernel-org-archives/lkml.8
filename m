Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECBC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 22:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E2B2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 22:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="jMv03MAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDZWTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgDZWTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 18:19:47 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE7C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F/y0or3JoEsWto7InGi9nTcZFDuoRRWXC7eq5TTRmRs=; b=jMv03MAhKuTRL2wutX8JGQEeGC
        pjxMxAmHNvSe4cyYtz3CkW+XWkBPIV+6+NI3wn9rW4B9DNfC0j3kEzrNCiiyLmz6cj4pQlq/g92df
        s/7Kfk2S80rJgFMktJRrVacsxGA7lXX8qLvKhoY1JerxcssqcWa87EpMYkGHMXIjnY5BF9uoQhSWN
        Tv9TSSxke0H1cb0VsYymcsmvUDSD1JoWerr3mktiA6Fuu0CScFcxsFVG2HuvaNwqOn2h7dNB+JH7k
        NT4gzgeC+MjGqkxcqUSySluNDSc8t6FDupXPl6Bu0yaG/E4VjvI7RGkiNBgxIPOUZGAFZ1U762HGf
        bjVlqNDg==;
Received: from [2a01:79c:cebf:7fb0:d967:6cf9:736f:4613] (port=42354)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1jSpcl-0001w6-5c; Mon, 27 Apr 2020 00:19:43 +0200
Subject: Re: Linux 5.7-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiDq0imdGHZwCnvWM1bc8r++==fB4BDrfenAB9_CZ45+w@mail.gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <4db6aa99-5c63-c8c7-921c-5136ae6643d6@skogtun.org>
Date:   Mon, 27 Apr 2020 00:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiDq0imdGHZwCnvWM1bc8r++==fB4BDrfenAB9_CZ45+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [26.04.2020 23:43]:

> Giovanni Gherdovich (3):
>       x86, sched: Bail out of frequency invariance if base frequency is unknown
>       x86, sched: Account for CPUs with less than 4 cores in freq. invariance
>       x86, sched: Move check for CPU type to caller function

This fixes the oops during boot on my ThinkPad T510i.
-- 
Hilsen Harald
