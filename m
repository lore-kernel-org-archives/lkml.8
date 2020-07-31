Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72F1206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbgGaSFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:05:30 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:48034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733310AbgGaSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:05:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 044C4182251B0;
        Fri, 31 Jul 2020 18:05:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: prose87_2707e7626f85
X-Filterd-Recvd-Size: 1202
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Jul 2020 18:05:28 +0000 (UTC)
Message-ID: <83fc36d8c87408298a4cd6d66b140b330f2c45b0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: skip macros when finding missing
 switch/case break
From:   Joe Perches <joe@perches.com>
To:     Cambda Zhu <cambda@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 31 Jul 2020 11:05:27 -0700
In-Reply-To: <20200729125911.47318-1-cambda@linux.alibaba.com>
References: <20200729125911.47318-1-cambda@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-29 at 20:59 +0800, Cambda Zhu wrote:
> The checkpatch.pl only searches 3 previous lines when finding missing
> switch/case break, and macros are treated as normal statements. If the
> cases are surrounded with CONFIG, checkpatch.pl may report false
> warnings. For example:

Likely this test should be removed altogether as
it's never really worked well and now compilers
find this and emit warnings.


