Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D656AC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E8E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bdDCDEzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgAPJeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:34:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:37072 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgAPJeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:34:08 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47yzXs45Nbz9tyQL;
        Thu, 16 Jan 2020 10:34:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=bdDCDEzJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id U8nIyqefG5v1; Thu, 16 Jan 2020 10:34:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47yzXs32ysz9tyQK;
        Thu, 16 Jan 2020 10:34:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579167245; bh=IEAXhb+SjJPqUD1Zb1vn+3GKKBJH4VCJ7C1isv48Ggo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=bdDCDEzJBDKpMZIDPaRWu1S7MBHDg8dEK/pOSodR7nkO7rmvqqSCxIv61NAvEMhly
         tjKfoP0FRRzhZS1bpnBkPx0HorlJWRmdde8ZBqSQydFJDMA3Pi0ZBFQ1VyF30EViUU
         NycCRX/C3sPS8WXWWvuHzglQQvP8REiOzojyMsSs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E9CC8B812;
        Thu, 16 Jan 2020 10:34:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CZ-uRnBuwtrT; Thu, 16 Jan 2020 10:34:06 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E40738B810;
        Thu, 16 Jan 2020 10:34:05 +0100 (CET)
Subject: Re: [PATCH v5 0/4] KASAN for powerpc64 radix
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
References: <20200109070811.31169-1-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8a1b7f4b-de14-90fe-2efa-789882d28702@c-s.fr>
Date:   Thu, 16 Jan 2020 10:34:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200109070811.31169-1-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/01/2020 à 08:08, Daniel Axtens a écrit :
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to 64-bit Book3S kernels running on the Radix MMU.
> 
> This provides full inline instrumentation on radix, but does require
> that you be able to specify the amount of physically contiguous memory
> on the system at compile time. More details in patch 4.

This might be a stupid idea as I don't know ppc64 much. IIUC, PPC64 
kernel can be relocated, there is no requirement to have it at address 
0. Therefore, would it be possible to put the KASAN shadow mem at the 
begining of the physical memory, instead of putting it at the end ?
That way, you wouldn't need to know the amount of memory at compile time 
because KASAN shadow mem would always be at address 0.

Christophe
