Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E31FC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBCB221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N/0lT/ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgDQGQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726710AbgDQGQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:16:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A387C061A0C;
        Thu, 16 Apr 2020 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=mE/dOyjqqJ9UifL3Sk+D0V7qq7bhB7t90DrI6tsIv9E=; b=N/0lT/tsDvJ/dX88bNUzPMtL3Z
        p1EXWZ4Vc/DtWTm9H9X05+yrqEFN8Nu2V/dPA1pqLtPnkYf4MCw/glE3oQOQdtbVT0riA0oIGBXf9
        rAWt2loIuoL0NgO0MIYmKhcp/+/p/nVfXFIQQEn6NomgL10oGmMw/Q9dHh32twFe564xFag5Ahs4W
        EdKdvbncyMl83MZU6tWvCjr/YJFjgzE0vlMTGGKTevzU/TftBTLyuYib18C+3x9svXgnZqifTOT2e
        XA/hzVPY5zDHWcnr5KAx+ED54T4pslv2r7FltTKxE2+491ZbSsWML+QGSuM71GqMcXnEHRE9mv4pL
        ertWKfQQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPKIU-0002vF-Uf; Fri, 17 Apr 2020 06:16:19 +0000
Subject: Re: linux-next: Tree for Apr 17 (pinctrl-mcp23s08)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20200417145017.3932443d@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0f828695-71cc-ab94-e0f0-ae63a192b283@infradead.org>
Date:   Thu, 16 Apr 2020 23:16:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417145017.3932443d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 9:50 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200416:
> 

on i386:

WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pinctrl-mcp23s08.o

 
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
