Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9288C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA61120828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBXJz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:55:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49257 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgBXJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:55:27 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6AST-0007Qj-D2; Mon, 24 Feb 2020 10:55:25 +0100
Date:   Mon, 24 Feb 2020 10:55:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zanussi@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 22/25] mm/memcontrol: Move misplaced
 local_unlock_irqrestore()
Message-ID: <20200224095525.coyyazg5hee4o6uy@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <960a2d2ccb60853d52f0dab91e391473dfa6035e.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <960a2d2ccb60853d52f0dab91e391473dfa6035e.1582320278.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21 15:24:50 [-0600], zanussi@kernel.org wrote:
> From: Matt Fleming <matt@codeblueprint.co.uk>
> 
> v4.14.170-rt75-rc1 stable review patch.
> If anyone has any objections, please let me know.

For this and the three following: Please skip it if it is not (yet) part
of v4.19-RT.

Sebastian
