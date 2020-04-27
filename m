Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD98DC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE7C2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgD0HSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:18:22 -0400
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:48024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbgD0HSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:18:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 95AAE181D3025;
        Mon, 27 Apr 2020 07:18:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: curve16_82cecc1d91724
X-Filterd-Recvd-Size: 1839
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 07:18:18 +0000 (UTC)
Message-ID: <cfc8fd0fbef54262f7cf714726b7b7cafc8c567e.camel@perches.com>
Subject: Re: [PATCH] drm/amd/display: remove conversion to bool in
 dcn20_mpc.c
From:   Joe Perches <joe@perches.com>
To:     Jason Yan <yanaijie@huawei.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Apr 2020 00:18:17 -0700
In-Reply-To: <20200427063715.21255-1-yanaijie@huawei.com>
References: <20200427063715.21255-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 14:37 +0800, Jason Yan wrote:
> The '==' expression itself is bool, no need to convert it to bool again.

trivia:

These descriptions are not quite correct.
The operators return an int, either 0 or 1.

-----------------
6.5.8 Relational operators

6 Each of the operators < (less than), > (greater than), <= (less than or equal to), and >=
(greater than or equal to) shall yield 1 if the specified relation is true and 0 if it is false. 90)
The result has type int

6.5.9 Equality operators

3 The == (equal to) and != (not equal to) operators are analogous to the relational
operators except for their lower precedence. 91) Each of the operators yields 1 if the
specified relation is true and 0 if it is false. The result has type int. For any pair of
operands, exactly one of the relations is true.
-----------------




