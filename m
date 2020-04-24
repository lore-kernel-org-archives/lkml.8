Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A353C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A09420724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha6uPj9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgDXR3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:29:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54354 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbgDXR3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vIOxP7fG+TeLcOzSq+qdoMyg4FKNqoorzxBOlNsN/4=;
        b=ha6uPj9vWRgzgOUW9ZR2OtRSzDMn28SjxLcHScMAwyH8SmMfduYA+Jx//brhuTrtKfCpWG
        NiAEsTr57fuBPdnPQD5uOk/IodRxelXlGa2sZf/NudUNPLd38qqz+u60mQDC0ydk1gPys6
        H0Xl0+3S5O+XID9JLIJ0PEBe0r8r+bE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267--Wp-HxUqNuyc1d_IjMnhrQ-1; Fri, 24 Apr 2020 13:29:19 -0400
X-MC-Unique: -Wp-HxUqNuyc1d_IjMnhrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 097041005510;
        Fri, 24 Apr 2020 17:29:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 02075610EC;
        Fri, 24 Apr 2020 17:29:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 24 Apr 2020 19:29:17 +0200 (CEST)
Date:   Fri, 24 Apr 2020 19:29:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] proc: Use PIDTYPE_TGID in next_tgid
Message-ID: <20200424172914.GA26802@redhat.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org>
 <87368uxa8x.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87368uxa8x.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23, Eric W. Biederman wrote:
>
> @@ -3360,20 +3360,8 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
>  	pid = find_ge_pid(iter.tgid, ns);
>  	if (pid) {
>  		iter.tgid = pid_nr_ns(pid, ns);
> -		iter.task = pid_task(pid, PIDTYPE_PID);
> -		/* What we to know is if the pid we have find is the
> -		 * pid of a thread_group_leader.  Testing for task
> -		 * being a thread_group_leader is the obvious thing
> -		 * todo but there is a window when it fails, due to
> -		 * the pid transfer logic in de_thread.
> -		 *
> -		 * So we perform the straight forward test of seeing
> -		 * if the pid we have found is the pid of a thread
> -		 * group leader, and don't worry if the task we have
> -		 * found doesn't happen to be a thread group leader.
> -		 * As we don't care in the case of readdir.
> -		 */
> -		if (!iter.task || !has_group_leader_pid(iter.task)) {
> +		iter.task = pid_task(pid, PIDTYPE_TGID);
> +		if (!iter.task) {
>  			iter.tgid += 1;
>  			goto retry;
>  		}

Acked-by: Oleg Nesterov <oleg@redhat.com>

