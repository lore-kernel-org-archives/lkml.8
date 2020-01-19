Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C843C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E511246A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579392930;
	bh=QxrhY1ZKchdqWCJT4FNp5gz+287Q3KNekwrVRqV+e94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eRGu58dOjybIlcSUjkse68DN1jwBS/rxLlw182HjXkTtDsBfMjV22/PLf1rLHWCZX
	 w75qZTpvyiUiBkdWl0uAYVRQhCpMDS8Oa+tB1aTazIxm5WAazJWQbiCIeX/wNWgfk+
	 JdD5iIidkCAPnHHgtobB1oAF/VlxGyNZKDb+fGVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgASAP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 19:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgASAP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 19:15:29 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9968A2467C;
        Sun, 19 Jan 2020 00:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579392928;
        bh=QxrhY1ZKchdqWCJT4FNp5gz+287Q3KNekwrVRqV+e94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TBXEcN4iqXSY4fSimgm4USfM8u4H+05c1/LKA2xyic31a3LtvlsRc+Vr5e0rvtD/Q
         Wz+JdoLGxxwOwO4E0xMrZc6/DQXc3Y98Owk9i0ssYJZN9daSwM469C1nMGDXD+t2Sy
         I4Amt+WEGFpi+Nch/DSPpKghDlp8xhKw99iqRdWo=
Date:   Sat, 18 Jan 2020 16:15:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-Id: <20200118161528.94dc18c074aeaa384200486b@linux-foundation.org>
In-Reply-To: <20200117171331.GA17179@blackbody.suse.cz>
References: <20191127174317.GD26807@dhcp22.suse.cz>
        <20191204132812.GF25242@dhcp22.suse.cz>
        <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
        <20191204153225.GM25242@dhcp22.suse.cz>
        <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
        <20191204173224.GN25242@dhcp22.suse.cz>
        <20200106115733.GH12699@dhcp22.suse.cz>
        <alpine.DEB.2.21.2001061550270.23163@www.lameter.com>
        <20200109145236.GS4951@dhcp22.suse.cz>
        <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org>
        <20200117171331.GA17179@blackbody.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 18:13:31 +0100 Michal Koutn=FD <mkoutny@suse.com> wrote:

> Hello.
>=20
> On Thu, Jan 09, 2020 at 11:44:15AM -0800, Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > I looked at it - there wasn't really any compelling followup.
> FTR, I noticed udevd consuming non-negligible CPU cycles when doing some
> cgroup stress testing. And even extrapolating to less artificial
> situations, the udev events seem to cause useless tickling of udevd.
>=20
> I used the simple script below
> cat measure.sh <<EOD
> sample() {
>         local n=3D$(echo|awk "END {print int(40/$1)}")
>=20
>         for i in $(seq $n) ; do
>                 mkdir /sys/fs/cgroup/memory/grp1 ;
>                 echo 0 >/sys/fs/cgroup/memory/grp1/cgroup.procs ;
>                 /usr/bin/sleep $1 ;
>                 echo 0 >/sys/fs/cgroup/memory/cgroup.procs ;
>                 rmdir /sys/fs/cgroup/memory/grp1 ;
>         done
> }
>=20
> for d in 0.004 0.008 0.016 0.032 0.064 0.128 0.256 0.5 1 ; do
>         echo 0 >/sys/fs/cgroup/cpuacct/system.slice/systemd-udevd.service=
/cpuacct.usage
>         time sample $d 2>&1 | grep real
>         echo -n "udev "
>         cat /sys/fs/cgroup/cpuacct/system.slice/systemd-udevd.service/cpu=
acct.usage
> done
> EOD
>=20
> and I drew the following ballpark conclusion:
> 1.7% CPU time at 1 event/s -> 60 event/s 100% cpu
>=20
> (The event is one mkdir/migrate/rmdir sequence. Numbers are from dummy
> test VM, so take with a grain of salt.)

Thanks.  What effect does this patch have upon these numbers?

>=20
> > If this change should be pursued then can we please have a formal
> > resend?
> Who's supposed to do that?

Typically the author, but not always.  If someone else is particularly
motivated to get a patch merged up they can take it over.

