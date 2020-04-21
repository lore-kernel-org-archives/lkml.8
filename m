Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC26C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946652072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNYvvefz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDUVzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgDUVzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:55:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28271C0610D5;
        Tue, 21 Apr 2020 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=WSRDHHqIxHFinzbpcekxPnOsUzINv8MxhhG+hklCXVQ=; b=hNYvvefzVJVOtgakBK02bMYcr6
        dEOzwyCcvFOcj6Div94z6uopHknDn3pTnxgJ82WtV2nDqcnKi/TGvPiV+aTB1v9Y/3UplFjO+1b05
        71ssXKuHjUM6HySjoQYYdBnhmbJXSTqQtN2RUp+hk7Gs0lMkP7kWw5/f81OWAIalGi6GHkW0hcbjl
        fv+fnslfUuDZsWbAecOpo3RZJI0Hjj03YtdMmnrB4e7JDQyodUvHhdmIiA1KfLWB+YvNP7Ym4O/OT
        ePc/IQn7pvIO8k4rBLbVqh2vNriJJ7ZJ1qGLFSbNivvvwHh9Ipb8jP0ELBFUHNJl/TbYi4rI+nHaA
        qRZ43J6Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR0rK-0000qF-Ul; Tue, 21 Apr 2020 21:55:15 +0000
Subject: Re: [PATCH] Documentation: LSM: Correct the basic LSM description
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Summit Program Committee 
        <lss-pc@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Morris <jmorris@namei.org>
References: <4c053d72-2d58-612f-6d6b-f04226d0181e.ref@schaufler-ca.com>
 <4c053d72-2d58-612f-6d6b-f04226d0181e@schaufler-ca.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0efe8670-cbd7-9633-dbd3-ad04272e6806@infradead.org>
Date:   Tue, 21 Apr 2020 14:55:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4c053d72-2d58-612f-6d6b-f04226d0181e@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 2:48 PM, Casey Schaufler wrote:
> This is a first pass at updating the basic documentation on
> Linux Security Modules (LSM), which is frighteningly out of date.
> Remove untrue statements about the LSM framework. Replace them
> with true statements where it is convenient to do so. This is
> the beginnig of a larger effort to bring the LSM documentation
> up to date.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/security/lsm.rst | 202 ++++++++++++++---------------------------
>  1 file changed, 66 insertions(+), 136 deletions(-)


-- 
~Randy
