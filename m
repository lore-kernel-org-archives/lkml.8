Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03789C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC73F24684
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgA0XEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:04:55 -0500
Received: from gentwo.org ([3.19.106.255]:56170 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgA0XEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:04:54 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 7C85D3F25A; Mon, 27 Jan 2020 23:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 7B7BE3E9B5;
        Mon, 27 Jan 2020 23:04:53 +0000 (UTC)
Date:   Mon, 27 Jan 2020 23:04:53 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
In-Reply-To: <20200127173336.GB17425@blackbody.suse.cz>
Message-ID: <alpine.DEB.2.21.2001272304080.25307@www.lameter.com>
References: <alpine.DEB.2.21.1912041524290.18825@www.lameter.com> <20191204153225.GM25242@dhcp22.suse.cz> <alpine.DEB.2.21.1912041652410.29709@www.lameter.com> <20191204173224.GN25242@dhcp22.suse.cz> <20200106115733.GH12699@dhcp22.suse.cz>
 <alpine.DEB.2.21.2001061550270.23163@www.lameter.com> <20200109145236.GS4951@dhcp22.suse.cz> <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org> <20200117171331.GA17179@blackbody.suse.cz> <20200118161528.94dc18c074aeaa384200486b@linux-foundation.org>
 <20200127173336.GB17425@blackbody.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-106161774-1580166293=:25307"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-106161774-1580166293=:25307
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 27 Jan 2020, Michal Koutný wrote:

> When I rerun the script with patched kernel, udev sit mostly idle (there
> were no other udev event sources). So the number can be said to drop to
> 0% CPU time / event/s.
>
> > Typically the author, but not always.  If someone else is particularly
> > motivated to get a patch merged up they can take it over.
> Christopher, do you consider resending your patch? (I second that it
> exposes the internal details (wrt cgroup caches) and I can observe the
> just reading the events by udevd wastes CPU time.)

The patch exposes details of cgroup caches? Which patch are we talking
about?
--531401748-106161774-1580166293=:25307--
