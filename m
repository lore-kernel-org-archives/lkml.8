Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40758C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C19206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598963587;
	bh=KE1xs5LcfwiWkzkTpbdPbOYkwIp0/7kyWYjObuo2KO4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=y93taFC8Iu+hBhtl9KeZlHvvrGSI/RshZ6GUGy2Gta7BOLYxCRQtGntKxeSzDz713
	 01NSKWT5FpevQ6EauTdcGc53FjlID/cowZZFDeLTom7x1VTd+up4RQ98iBehFn2fqK
	 r0wpuiXTtNHy3XBu6zypDEhl799WSiz0qy9X5r94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgIAMcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgIAMQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:16:44 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474AC20767;
        Tue,  1 Sep 2020 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598962599;
        bh=KE1xs5LcfwiWkzkTpbdPbOYkwIp0/7kyWYjObuo2KO4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tn611PWD6JNkm49ixzFeSGx74+dvxWUiNYWLf5JEF+YZZCnGEgXWTPnVgJG2WFCXa
         gmiXnhtfutDeifufLNP3/4jTQwTeexdvb3v/QG0oABwPlsge1bxYAgGJ0PhFIl7/gL
         f4ntgjPhArAYZXVdFNW9cUGdqsPBKlsNHE2eXwYQ=
Date:   Tue, 1 Sep 2020 14:16:37 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Joe Perches <joe@perches.com>
cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [trivial treewide PATCH] treewide: Fix misuses of 0x<decimal>%x
 format specifiers
In-Reply-To: <ea0852c8a2c7bbae813c2b389e0ba44b31f0b7a0.camel@perches.com>
Message-ID: <nycvar.YFH.7.76.2009011416020.4671@cbobk.fhfr.pm>
References: <eb1d6f204103bac5ff81dabffa212c340432b813.camel@perches.com> <ea0852c8a2c7bbae813c2b389e0ba44b31f0b7a0.camel@perches.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020, Joe Perches wrote:

> > These are almost all typos where the decimal length value
> > should be after the % not before it.
> 
> Hey Jiri:
> 
> Is the trivial tree still alive?
> Do you even look at this stuff anymore?

I am, but it's obviously not my daily bread. But I try to process the 
pending patches at least once during the -rc cycle now.

-- 
Jiri Kosina
SUSE Labs

