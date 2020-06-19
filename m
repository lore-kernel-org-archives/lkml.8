Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A130EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F1F20888
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lq/FbWDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgFSDEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgFSDEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:04:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7739C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=RyOedWdDkEkqAvGtwSIml+F/VSNBeUwhekqgRlaP02g=; b=lq/FbWDszOaQUk844aFOKUEYlS
        82HGROQE4XlEzQc/E6qUEdtxBMFyv69amyPLvh1piUT1+zqFvLVu3shYG+q9jFgMPk3eLg+9GZlfR
        l5/hWZAP0rtetvzTdVSpXnWBl40PLZ113GP64pmC1mw14KsJRtdROhVUNfX6CHGtd3NbF8P2Et8in
        Xdb2kdbXcldW1QSQ6a61aKiGXc832Uul6AyvO+PmbTmTQ1bXevpGhyNjkcG85W8vUapAEvpOegRig
        jzakj0WHXtwhjgtsFzmMc+wmY6eN/GhWZlmjT4nXCKO7wkI5ej2fl8ctPg41C10ztzbi4BTRlq5qv
        yqU4Rl3w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jm7Kh-0000km-LT; Fri, 19 Jun 2020 03:04:47 +0000
Subject: Re: PC speaker
To:     "R.F. Burns" <burnsrf@gmail.com>, linux-kernel@vger.kernel.org
References: <CABG1boOyDJheyNFuxhB0amA3_NH_DtvtZb2BBUtUOCQ01jeCEw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b6dbd072-ec5b-8542-dcd4-0b19621660fb@infradead.org>
Date:   Thu, 18 Jun 2020 20:04:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CABG1boOyDJheyNFuxhB0amA3_NH_DtvtZb2BBUtUOCQ01jeCEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/20 10:49 AM, R.F. Burns wrote:
> Is it possible to write a kernel module which, when loaded, will blow
> the PC speaker?
> 

Are you still having problems with those school students?


https://marc.info/?l=linux-kernel&m=118167999520788&w=2

-- 
~Randy

