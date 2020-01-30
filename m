Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BABC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 01:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B2520716
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 01:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgA3BWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 20:22:15 -0500
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:49140 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgA3BWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 20:22:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 04DC9100E7B42;
        Thu, 30 Jan 2020 01:22:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tank25_3070df626a919
X-Filterd-Recvd-Size: 1170
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Jan 2020 01:22:12 +0000 (UTC)
Message-ID: <14c4cd0d74d9de88f8cf16bad8910f1273a46a47.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check SPDX tags in YAML files
From:   Joe Perches <joe@perches.com>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Jan 2020 17:21:05 -0800
In-Reply-To: <20200129123356.388669-1-lkundrak@v3.sk>
References: <20200129123356.388669-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-29 at 13:33 +0100, Lubomir Rintel wrote:
> This adds a warning when a YAML file is lacking a SPDX header on first
> line, or it uses incorrect commenting style.
> 
> Currently the only YAML files in three are Devicetree binding documents.

three/tree typo?

Otherwise, looks fine.

