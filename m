Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B17C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147212072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgFBGDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgFBGDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:03:04 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BA8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 23:03:03 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 4FC2AC009; Tue,  2 Jun 2020 08:03:01 +0200 (CEST)
Date:   Tue, 2 Jun 2020 08:02:46 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, ericvh@gmail.com,
        lucho@ionkov.net,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2] 9p/xen: increase XEN_9PFS_RING_ORDER
Message-ID: <20200602060246.GA16791@nautica>
References: <20200521193242.15953-1-sstabellini@kernel.org>
 <20200522055847.GA2833@nautica>
 <alpine.DEB.2.21.2006011406100.12801@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006011406100.12801@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Stabellini wrote on Mon, Jun 01, 2020:
> > LGTM, I'll try to find some time to test this by the end of next week or
> > will trust you if I can't make it -- ping me around June 1st if I don't
> > reply again until then...
> 
> Ping :-)

I actually did think about this patch this weekend! . . .but didn't
quite make it :/
Anyway, as promised pushed to linux-next, I'll submit this for 5.8

-- 
Dominique
