Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C148BC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927D820704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGJB6dmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgDXSGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:06:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726908AbgDXSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587751595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rONQ14r6qvN7gJ7mKqkG2OoVzfp4fKCxczov4WFzxCA=;
        b=VGJB6dmyV1kH5SBrhs9aBxoo0mC/v/eH6NMGcI3m87tSBrPXzF9dxd/D3MA1t3z6PP15gG
        c2PYdQLypst12cOAQ/7CfH0m/IfsTz51Ah+62j44O0+xpyfnLAa/CE/Dn/ZWoZe7juFGTa
        cUWWtZpAy3BZqk4jY0egky5svSd4YaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-dsy-F9NNOKuADJgf5Wk6Wg-1; Fri, 24 Apr 2020 14:06:30 -0400
X-MC-Unique: dsy-F9NNOKuADJgf5Wk6Wg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3C7D855875;
        Fri, 24 Apr 2020 18:05:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 345DE6084A;
        Fri, 24 Apr 2020 18:05:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 24 Apr 2020 20:05:26 +0200 (CEST)
Date:   Fri, 24 Apr 2020 20:05:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] remove the no longer needed pid_alive() check in
 __task_pid_nr_ns()
Message-ID: <20200424180523.GD26802@redhat.com>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421090426.GA6787@redhat.com>
 <20200421101904.GA9358@redhat.com>
 <87mu74517d.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu74517d.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Starting from 2c4704756cab ("pids: Move the pgrp and session pid pointers
> > from task_struct to signal_struct") __task_pid_nr_ns() doesn't dereference
> > task->group_leader, we can remove the pid_alive() check.
> >
> > pid_nr_ns() has to check pid != NULL anyway, pid_alive() just adds the
> > unnecessary confusion.
> >
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks, can you take this patch?

Oleg.

