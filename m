Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE30DC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9002176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5QmMgOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBRVMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:12:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48926 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbgBRVMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582060352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TytcvhOjkyHfTw6KUg4tUJML98qBc3OS2NlpStP6zV0=;
        b=Y5QmMgOm8S9VMlJCHuOBcWc7w3E64q895rb6E56d1z3mfQXfaa8fdsztXwl9qh5msjbnVx
        OyfBrgjMI86wGYnaKCswz+CeeCM4C7QnXml1NzpkX4AWSFMNwEKOwIkOmoa98aNy2M+FkL
        AJD1+PTlQ7mDcjrGAGu4zjQ5n+v0Y90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-DDUhTt-6NBOs4isdYsi40A-1; Tue, 18 Feb 2020 16:12:30 -0500
X-MC-Unique: DDUhTt-6NBOs4isdYsi40A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22BAF800D55;
        Tue, 18 Feb 2020 21:12:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.rdu2.redhat.com [10.10.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 975725C13B;
        Tue, 18 Feb 2020 21:12:21 +0000 (UTC)
Date:   Tue, 18 Feb 2020 16:12:19 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, eparis@parisplace.org
Subject: Re: [PATCH ghak28 V6] audit: log audit netlink multicast bind and
 unbind events
Message-ID: <20200218211219.scmmx3yut3mukzc6@madcap2.tricolour.ca>
References: <857c76090363b6316a89d292cf9cccd0db54c079.1582058914.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857c76090363b6316a89d292cf9cccd0db54c079.1582058914.git.rgb@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-18 15:51, Richard Guy Briggs wrote:
> Log information about programs connecting to and disconnecting from the
> audit netlink multicast socket. This is needed so that during
> investigations a security officer can tell who or what had access to the
> audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> Criteria.  Here is the systemd startup event:
> 
> type=PROCTITLE msg=audit(2020-02-18 15:26:50.775:10) : proctitle=/init
> type=SYSCALL msg=audit(2020-02-18 15:26:50.775:10) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x19 a1=0x55645c369b70 a2=0xc a3=0x7fff9fedec24 items=0 ppid=0 pid=1 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=systemd exe=/usr/lib/systemd/systemd subj=kernel key=(null)
> type=UNKNOWN[1335] msg=audit(2020-02-18 15:26:50.775:10) : pid=1 uid=root auid=unset tty=(none) ses=unset subj=kernel comm=systemd exe=/usr/lib/systemd/systemd nl-mcgrp=1 op=connect res=yes
> 
> And the events from the test suite:
> 
> type=PROCTITLE msg=audit(2020-02-18 15:28:01.594:307) : proctitle=/usr/bin/perl -w amcast_joinpart/test
> type=SOCKADDR msg=audit(2020-02-18 15:28:01.594:307) : saddr={ saddr_fam=netlink nlnk-fam=16 nlnk-pid=0 }
> type=SYSCALL msg=audit(2020-02-18 15:28:01.594:307) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x7 a1=0x558ebc428be0 a2=0xc a3=0x0 items=0 ppid=642 pid=645 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=UNKNOWN[1335] msg=audit(2020-02-18 15:28:01.594:307) : pid=645 uid=root auid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=connect res=yes
> 
> type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.051:295) : pid=674 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes
> 
> Please see the upstream issue tracker:
>   https://github.com/linux-audit/audit-kernel/issues/28
>   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-Socket-Join-Part
>   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-join
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

This was slightly premature.  I had intended to send the ghak120 (norule
missing accompanying) patch first to start a discussion.  The results
above are depending on that patch.

> ---
> Note: msg type 1334 was skipped due to BPF accepted in another tree.
> Note: v5 due to previous 2014-10-07, 2015-07-23, 2016-11-30, 2017-10-13
> Note: subj attrs included due to missing syscall record for systemd (audit=1)
> Note: tried refactor of subj attrs, but this is yet another new order.
> ---
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index a534d71e689a..9b6a973f4cc3 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -117,6 +117,7 @@
>  #define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
>  #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
>  #define AUDIT_BPF		1334	/* BPF subsystem */
> +#define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket */
>  
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 17b0d523afb3..478259f3fa53 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
>  	audit_ctl_unlock();
>  }
>  
> +/* Log information about who is connecting to the audit multicast socket */
> +static void audit_log_multicast_bind(int group, const char *op, int err)
> +{
> +	const struct cred *cred;
> +	struct tty_struct *tty;
> +	char comm[sizeof(current->comm)];
> +	struct audit_buffer *ab;
> +
> +	if (!audit_enabled)
> +		return;
> +
> +	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_LISTENER);
> +	if (!ab)
> +		return;
> +
> +	cred = current_cred();
> +	tty = audit_get_tty();
> +	audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
> +			 task_pid_nr(current),
> +			 from_kuid(&init_user_ns, cred->uid),
> +			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
> +			 tty ? tty_name(tty) : "(none)",
> +			 audit_get_sessionid(current));
> +	audit_put_tty(tty);
> +	audit_log_task_context(ab); /* subj= */
> +	audit_log_format(ab, " comm=");
> +	audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +	audit_log_d_path_exe(ab, current->mm); /* exe= */
> +	audit_log_format(ab, " nl-mcgrp=%d op=%s res=%d", group, op, !err);
> +	audit_log_end(ab);
> +}
> +
>  /* Run custom bind function on netlink socket group connect or bind requests. */
> -static int audit_bind(struct net *net, int group)
> +static int audit_multicast_bind(struct net *net, int group)
>  {
> +	int err = 0;
> +
>  	if (!capable(CAP_AUDIT_READ))
> -		return -EPERM;
> +		err = -EPERM;
> +	audit_log_multicast_bind(group, "connect", err);
> +	return err;
> +}
>  
> -	return 0;
> +static void audit_multicast_unbind(struct net *net, int group)
> +{
> +	audit_log_multicast_bind(group, "disconnect", 0);
>  }
>  
>  static int __net_init audit_net_init(struct net *net)
>  {
>  	struct netlink_kernel_cfg cfg = {
>  		.input	= audit_receive,
> -		.bind	= audit_bind,
> +		.bind	= audit_multicast_bind,
> +		.unbind	= audit_multicast_unbind,
>  		.flags	= NL_CFG_F_NONROOT_RECV,
>  		.groups	= AUDIT_NLGRP_MAX,
>  	};
> -- 
> 1.8.3.1
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

