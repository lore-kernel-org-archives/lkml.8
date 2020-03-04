Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF812166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCDFz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:55:27 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:44226 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgCDFz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:55:26 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7851680558;
        Wed,  4 Mar 2020 06:55:22 +0100 (CET)
Date:   Wed, 4 Mar 2020 06:55:21 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 2/3] kbuild: allow to run dt_binding_check and dtbs_check
 in a single command
Message-ID: <20200304055520.GA28911@ravnborg.org>
References: <20200304032038.14424-1-masahiroy@kernel.org>
 <20200304032038.14424-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304032038.14424-3-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=T9RiHNw9UjFK13vW5GoA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro

Thanks for the nice improvements to the dt infrastructure.

Stealing a thread here..

>  It is also possible to run checks with a single schema file by setting the
>  ``DT_SCHEMA_FILES`` variable to a specific schema file.
Would it be simple to enable the use of dirs for DT_SCHEMA_FILES?

So I for example could do:

make dt_bindings_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/

I did a very quick look add it but failed to dechiper all the
makefile logic.

It is a corner case when one wants to check a full dir,
so unless it is very simple the current logic should not
be complicated by this (if you take the bait and look at it).

	Sam
