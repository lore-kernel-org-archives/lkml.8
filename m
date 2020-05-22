Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E00C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFC620723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGnXSraH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgEVQp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgEVQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:45:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C23C061A0E;
        Fri, 22 May 2020 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=yEhxxNKQdXzNMNpK5iqG9C1DffsR37ivyTpx1Xe3wbw=; b=FGnXSraHPDQnO69j4hl1rx+Ld7
        I4n4aU10HslG/DXrV+AYXXONhOIEGLFn4Mi8JV3qvtFLYkq01cFD8Uht3CQRtU4kaBifBXyUDnOBQ
        bF8EDhddAk/Lq3nXddzdio1euQw2TsYlfU8DUaCp31t7aAB25T15yCYUxf4bRKZ9kJkFvS9D4qaZb
        ncqtyXXtLFqayEGlH/IEB1pdvHQaSndxz3dDstFpGDPl3aD3QKs6/xkIciWBgOv33+2/DN/bIeC9Z
        K24lWwvxIKvxWomUbRoIrjou472NSndM+JjGDmv/XvxPzmPmWqur7Yf9oD46F3c2WFblstbmsAAtW
        KPUkwo5Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcAnz-0002dd-K1; Fri, 22 May 2020 16:45:55 +0000
Subject: Re: linux-next: Tree for May 22 (net/psample/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yotam Gigi <yotam.gi@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20200522225236.33ce1e69@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d216867a-8a52-3d62-05ce-628440f21c64@infradead.org>
Date:   Fri, 22 May 2020 09:45:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522225236.33ce1e69@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 5:52 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200521:
> 


on i386:

../net/psample/psample.c: In function ‘__psample_ip_tun_to_nlattr’:
../net/psample/psample.c:216:25: error: implicit declaration of function ‘ip_tunnel_info_opts’; did you mean ‘ip_tunnel_info_opts_set’? [-Werror=implicit-function-declaration]
  const void *tun_opts = ip_tunnel_info_opts(tun_info);
                         ^~~~~~~~~~~~~~~~~~~
                         ip_tunnel_info_opts_set
../net/psample/psample.c:216:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
