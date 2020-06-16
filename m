Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8458C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A6A20739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qjg3U8mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgFPNan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:30:43 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:13830 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgFPNam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:30:42 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GDLUeg002051;
        Tue, 16 Jun 2020 08:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=RF7XM/VGRybFmf05vTpj/Z7w7fFupQPckIlBEqKLPNI=;
 b=qjg3U8mrVDSfgaR2txJTguFX4NgUfHexwKN5sVrLt+9xz6ffWGxh1b3r6cmsCRoOJuY7
 ec2LfMLLbgXp0t6li8F5bq7BSBRBxCJLorxlqNB7kxFm+oOwaXUfOUxz9NX8rHw05iSo
 biUMeSJ9CF/UpY+H41l4esSXXfFZbGCE3s5qPXqUhKTsvJRsKqnYYLmZMnoBk17xkhMl
 8Jy6yXoZcFsbQd0CCfF2MGrhkRE9i1l7PTXg796x9XHl/rBwqgtMZYAuddvyca4JsSPb
 PDxPEbk4plrIgkDMi0wtZoLQEHFq7A48MlzkjK+QKxb45tV3xK6CjSYgOxmubP+/m72k Rw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31mu7p4fm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 08:30:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 16 Jun
 2020 14:30:39 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 16 Jun 2020 14:30:39 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 08EF9448;
        Tue, 16 Jun 2020 13:30:39 +0000 (UTC)
Date:   Tue, 16 Jun 2020 13:30:39 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] mfd: mfd-core: Add mechanism for removal of a
 subset of children
Message-ID: <20200616133039.GU71940@ediswmail.ad.cirrus.com>
References: <20200615150722.5249-1-ckeepax@opensource.cirrus.com>
 <20200616075834.GF2608702@dell>
 <20200616084748.GS71940@ediswmail.ad.cirrus.com>
 <20200616091545.GP2608702@dell>
 <20200616100625.GT71940@ediswmail.ad.cirrus.com>
 <20200616132259.GS2608702@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200616132259.GS2608702@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=893
 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 02:22:59PM +0100, Lee Jones wrote:
> On Tue, 16 Jun 2020, Charles Keepax wrote:
> > On Tue, Jun 16, 2020 at 10:15:45AM +0100, Lee Jones wrote:
> > > On Tue, 16 Jun 2020, Charles Keepax wrote:
> > > > On Tue, Jun 16, 2020 at 08:58:34AM +0100, Lee Jones wrote:
> > > > > On Mon, 15 Jun 2020, Charles Keepax wrote:
> > > > Does this match how you would expect this to be used?
> > > 
> > > No, not at all.
> > > 
> > > > I do have some concerns. The code can't use mfd_get_cell since it
> > > > returns a const pointer, although the pointer in platform_device
> > > > isn't const so we access that directly, could update mfd_get_cell? We
> > > > also don't have access to mfd_dev_type outside of the mfd core so
> > > > its hard to check we are actually setting the mfd_cell of actual
> > > > MFD children, I guess just checking for mfd_cell being not NULL is
> > > > good enough?
> > > 
> > > Hmmm... looks like I missed the fact that you needed additional
> > > processing between the removal of each batch of devices.  My
> > > implementation simply handles the order in which devices are removed
> > > (a bit like initcall()s).
> > > 
> > > How about the inclusion of mfd_remove_devices_late(), whereby
> > > mfd_remove_devices() will refuse to remove devices tagged with
> > > MFD_DEP_LEVEL_HIGH.
> > > 
> > 
> > Yeah this should work fine for my use-case.
> > 
> > > Not sure why, but I really dislike the idea of device removal by
> > > arbitrary value/tag, as I see it spawning all sorts of weird and
> > > wonderful implications/hacks/abuse.
> > > 
> > 
> > Its definitely a spectrum with flexibility covering more
> > use-cases but also definitely opening things up to more abuse. If
> > you are more comfortable with this approach that is fine with me.
> > 
> > Would you like me to have a crack at coding it up this way? Or
> > did you want to do a patch?
> 
> Either/or.  I don't want to steal your thunder, but I'm happy to draft
> if you are.
> 

Been having a poke this afternoon as I had some spare time, so
will wing that up and you can take over if I am too far off the
mark :-)

Thanks,
Charles
