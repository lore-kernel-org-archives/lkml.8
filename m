Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E66C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D79220724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHUSfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:35:55 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:54846 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbgHUSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:35:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6DC3E1822495E;
        Fri, 21 Aug 2020 18:35:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shoe97_390c3bd2703b
X-Filterd-Recvd-Size: 1887
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 18:35:52 +0000 (UTC)
Message-ID: <745aba13716b91cf58a45468083b59201d1530fc.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for HPE Superdome Flex (UV)
 maintainers
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Date:   Fri, 21 Aug 2020 11:35:50 -0700
In-Reply-To: <CAL_JsqL0v6PXgMLVZzqZwjpZ4KTUGmutg6Z0YuvTccdAUa-=mw@mail.gmail.com>
References: <20200821154848.GI7871@localhost.localdomain>
         <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
         <8213206d4764375f32cbea36ea214573248094dc.camel@perches.com>
         <CAL_JsqL0v6PXgMLVZzqZwjpZ4KTUGmutg6Z0YuvTccdAUa-=mw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 12:17 -0600, Rob Herring wrote:
> I have another reason for wanting the split. I want to generate a
> MAINTAINERS file from the DT schema files. We have the data there and
> it's checked automatically. I don't care to either continually tell
> folks to add a MAINTAINERS entry or tell them to run checkpatch.pl to
> tell them that. But if the infrastructure got merged, would that
> already work?

It already gets addresses from yaml files.
The same could be done for dts/dtsi files.

Last month I proposed:

https://lore.kernel.org/linux-arm-kernel/da52724655ff2161add7fb27fea8fc673028b9fc.camel@perches.com/


