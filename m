Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D04C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1010620704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGQIf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:35:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:39390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgGQIfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:35:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF2D5B636;
        Fri, 17 Jul 2020 08:35:26 +0000 (UTC)
Date:   Fri, 17 Jul 2020 10:35:21 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries: detect secure and trusted boot state
 of the system.
Message-ID: <20200717083521.GK32107@kitsune.suse.cz>
References: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com>
 <20200716081337.GB32107@kitsune.suse.cz>
 <87pn8uu1hy.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pn8uu1hy.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 03:58:01PM +1000, Daniel Axtens wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> 
> > On Wed, Jul 15, 2020 at 07:52:01AM -0400, Nayna Jain wrote:
> >> The device-tree property to check secure and trusted boot state is
> >> different for guests(pseries) compared to baremetal(powernv).
> >> 
> >> This patch updates the existing is_ppc_secureboot_enabled() and
> >> is_ppc_trustedboot_enabled() functions to add support for pseries.
> >> 
> >> The secureboot and trustedboot state are exposed via device-tree property:
> >> /proc/device-tree/ibm,secure-boot and /proc/device-tree/ibm,trusted-boot
> >> 
> >> The values of ibm,secure-boot under pseries are interpreted as:
> >                                       ^^^
> >> 
> >> 0 - Disabled
> >> 1 - Enabled in Log-only mode. This patch interprets this value as
> >> disabled, since audit mode is currently not supported for Linux.
> >> 2 - Enabled and enforced.
> >> 3-9 - Enabled and enforcing; requirements are at the discretion of the
> >> operating system.
> >> 
> >> The values of ibm,trusted-boot under pseries are interpreted as:
> >                                        ^^^
> > These two should be different I suppose?
> 
> I'm not quite sure what you mean? They'll be documented in a future
> revision of the PAPR, once I get my act together and submit the
> relevant internal paperwork.

Nevermind, one talks about secure boot, the other about trusted boot.

Thanks

Michal
