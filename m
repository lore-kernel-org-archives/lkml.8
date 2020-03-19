Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915DFC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698372071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgCSCAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 22:00:19 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:53368 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726596AbgCSCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:00:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 00188100E7B40;
        Thu, 19 Mar 2020 02:00:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: straw74_1f78e6f50a94d
X-Filterd-Recvd-Size: 1205
Received: from XPS-9350 (unknown [172.58.27.183])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Mar 2020 02:00:16 +0000 (UTC)
Message-ID: <bb163d6b706a7b07e8b2e1c51b0da72a5923af97.camel@perches.com>
Subject: Re: [PATCH v2] staging: rtl8192u: Corrects 'Avoid CamelCase' for
 variables
From:   Joe Perches <joe@perches.com>
To:     Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Date:   Wed, 18 Mar 2020 18:58:24 -0700
In-Reply-To: <20200318211205.188-1-c.cantanheide@gmail.com>
References: <20200318211205.188-1-c.cantanheide@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 21:12 +0000, Camylla Goncalves Cantanheide wrote:
> The variables of function setKey triggered a 'Avoid CamelCase'
> warning from checkpatch.pl. This patch renames these
> variables to correct this warning.

Please always try to improve the code for humans to read
over correcting mindless checkpatch messages.


