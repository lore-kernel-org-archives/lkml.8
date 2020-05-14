Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E33C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F3D20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgENKy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:54:26 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:46358 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENKyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:54:25 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jZBVO-0007Im-82; Thu, 14 May 2020 12:54:22 +0200
Date:   Thu, 14 May 2020 12:54:22 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kernel list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: netfilter: does the API break or something else ?
Message-ID: <20200514105422.GO17795@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Xiubo Li <xiubli@redhat.com>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kernel list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>
References: <cf0d02b2-b1db-7ef6-41b8-7c345b7d53d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0d02b2-b1db-7ef6-41b8-7c345b7d53d5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 13, 2020 at 11:20:35PM +0800, Xiubo Li wrote:
> Recently I hit one netfilter issue, it seems the API breaks or something 
> else.

Just for the record, this was caused by a misconfigured kernel.

Cheers, Phil
