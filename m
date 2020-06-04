Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E6A2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgFDJRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:17:41 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:59320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbgFDJRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:17:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 7FBE8837F27E;
        Thu,  4 Jun 2020 09:17:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lock32_040a1d426d96
X-Filterd-Recvd-Size: 3759
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jun 2020 09:17:36 +0000 (UTC)
Message-ID: <2aa49a543e6f48a6f428a37b63a06f9149870225.camel@perches.com>
Subject: Re: [PATCH] pinctrl: pxa: pxa2xx: Remove 'pxa2xx_pinctrl_exit()'
 which is unused and broken
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Thu, 04 Jun 2020 02:17:35 -0700
In-Reply-To: <20200604083120.GF22511@kadam>
References: <20200531073716.593343-1-christophe.jaillet@wanadoo.fr>
         <87h7vvb1s3.fsf@belgarion.home>
         <a2e34c9a-676f-d83f-f395-7428af038c16@wanadoo.fr>
         <20200601183102.GS30374@kadam>
         <CACRpkdasbS-4_ZwC-Ucm8tkSUW5tAQdUrXjxHXQ3J0goVYfgHw@mail.gmail.com>
         <20200604083120.GF22511@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-04 at 11:31 +0300, Dan Carpenter wrote:
> On Thu, Jun 04, 2020 at 12:08:49AM +0200, Linus Walleij wrote:
[]
> > Fixes means it fixes something that was wrong in that commit.
> > That's all. Whether syntactic or semantic or regression or
> > serious or not does not matter. It is also not compulsory to
> > add it is just helpful.
> 
> Fixes tag should be compulsory for actual bug fixes.  We had a the
> Bad Binder exploit last year because commit f5cb779ba163
> ("ANDROID: binder: remove waitqueue when thread exits.") had no Fixes
> tag and wasn't backported to Android kernels.

Fixes tags IMO should be exclusively for actual bug fixes
and should be mandatory.

Perhaps:
---
 Documentation/process/submitting-patches.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1699b7f8e63a..285a84ae79de 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -636,12 +636,14 @@ idea was not posted in a public forum. That said, if we diligently credit our
 idea reporters, they will, hopefully, be inspired to help us again in the
 future.
 
-A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
-is used to make it easy to determine where a bug originated, which can help
-review a bug fix. This tag also assists the stable kernel team in determining
-which stable kernel versions should receive your fix. This is the preferred
-method for indicating a bug fixed by the patch. See :ref:`describe_changes`
-for more details.
+A Fixes: tag indicates that the patch fixes a "bug". i.e.: a logic defect or
+regression in a previous commit.  A Fixes: tag should not be used to indicate
+that a previous commit had some trivial defect in spelling in the commit log or
+some whitespace defect.  The Fixes: tag is used to make it easy to determine
+where a bug originated, which can help review a bug fix. The Fixes: tag also
+assists the stable kernel team in determining which stable kernel versions
+should receive your fix. This is the preferred method for indicating a bug is
+fixed by the patch.  See :ref:`describe_changes` for more details.
 
 .. _the_canonical_patch_format:
 

