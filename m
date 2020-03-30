Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EAF20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8BpVAmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgC3Iql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:46:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43439 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729422AbgC3Iql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585558000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=235mzFXtWzoySYpbaveQKvChOB41dl+JsRSFM2voh5E=;
        b=C8BpVAmCxofa5rgQMUVZXIiu62OmEznNfs2kqIvnI1iVqvNYoUHugaRqIX5brbLHAWGGEL
        O+IqpKq8xCSUJVuqP439lTMwhBaqjqEAOLnmniySalPGJwd4g2jvG3iFM8tRHzjuJMgqx7
        PNyHBr8XTZIdyiN5+hWAY+Z5VgCbmTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-cHSXZ7S3N-e1sPsYe_XPvw-1; Mon, 30 Mar 2020 04:46:38 -0400
X-MC-Unique: cHSXZ7S3N-e1sPsYe_XPvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1C2F13F9;
        Mon, 30 Mar 2020 08:46:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0B921953DF;
        Mon, 30 Mar 2020 08:46:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 30 Mar 2020 10:46:36 +0200 (CEST)
Date:   Mon, 30 Mar 2020 10:46:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     ebiederm@xmission.com, christian.brauner@ubuntu.com, tj@kernel.org,
        akpm@linux-foundation.org, guro@fb.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, Mingfangsen <mingfangsen@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] signal: use kill_proc_info instead of kill_pid_info in
 kill_something_info
Message-ID: <20200330084632.GA13298@redhat.com>
References: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30, Zhiqiang Liu wrote:
>
> @@ -1552,12 +1552,8 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
>  {
>  	int ret;
> 
> -	if (pid > 0) {
> -		rcu_read_lock();
> -		ret = kill_pid_info(sig, info, find_vpid(pid));
> -		rcu_read_unlock();
> -		return ret;
> -	}
> +	if (pid > 0)
> +		return kill_proc_info(sig, info, pid);
> 

Acked-by: Oleg Nesterov <oleg@redhat.com>

