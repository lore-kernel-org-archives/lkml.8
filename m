Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E6C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EC920674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCQTBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:01:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42802 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:01:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jEHSg-0006KJ-Be; Tue, 17 Mar 2020 13:01:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jEHSf-0007gi-Em; Tue, 17 Mar 2020 13:01:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Simon Ser <contact@emersion.fr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "oleg\@redhat.com" <oleg@redhat.com>,
        "christian\@brauner.io" <christian@brauner.io>
References: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
Date:   Tue, 17 Mar 2020 13:58:46 -0500
In-Reply-To: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
        (Simon Ser's message of "Tue, 17 Mar 2020 17:54:47 +0000")
Message-ID: <87d09akduh.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jEHSf-0007gi-Em;;;mid=<87d09akduh.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+F15h1WKqYx5MbXi45XLT/2BZ2Do4QVqM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: SO_PEERCRED and pidfd
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Ser <contact@emersion.fr> writes:

> Hi all,
>
> I'm a Wayland developer and I've been working on protocol security,
> which involves identifying the process on the other end of a Unix
> socket [1]. This is already done by e.g. D-Bus via the PID, however
> this is racy [2].
>
> Getting the PID is done via SO_PEERCRED. Would there be interest in
> adding a way to get a pidfd out of a Unix socket to fix the race?

I think we are passing a struct pid through the socket metadata.
So it should be technically feasible.

However it does come with some long term mainteance costs.

The big question is what is a pid being used for when being passed.
Last I looked most of the justifications for using metadata like that
with unix domain sockets led to patterns of trust that were also
exploitable.

Looking at the proposale in [1] even if you have race free access
to /proc/<pid>/exe using pidfds it is possible to change /proc/<pid>/exe
to be anything you can map so that seems to be an example of a problem.

So it would be very nice to see a use case spelled out where
the pid reuse race mattered, and that trusting a pid makes sense.


I have to dash but I will think about this and see if I can give a
concrete example of using a capability model.  Other than the current
one that works (handing out trusted sockets at the logical beginning of
time).  Though frankly I am not certain there is anything much better
than that.

Eric






> Thanks,
>
> Simon Ser
>
> [1]: https://gitlab.freedesktop.org/wayland/weston/issues/206
> [2]: https://github.com/flatpak/flatpak/issues/2995
