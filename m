Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3393BC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EF32071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai41kCkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgC0T4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:56:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57668 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgC0T4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585339010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47M1/R1fKOfaD/fxe2Qq1Sh6Lnd4CcgXHtJqgS2HeLI=;
        b=Ai41kCkIA4/64efqe3miKGsZlI+7ZqbxCuPguNNczuOSXOWp8DWvKyhTK3pmA9uPSn+cHA
        FyF5plvJZdR3yOJu/Vgys5O0q35ym3WIoz8WYT0MHMhVDKad+OodYkPDcVkSlI2x9idF5/
        cHkU4bXlCLJNSbLdLKMI4Ai58ckbGPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-vYDegnzvOf6ERafJ4qbcTQ-1; Fri, 27 Mar 2020 15:56:48 -0400
X-MC-Unique: vYDegnzvOf6ERafJ4qbcTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 407AF85EE96;
        Fri, 27 Mar 2020 19:56:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.121])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D9298AC36;
        Fri, 27 Mar 2020 19:56:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 27 Mar 2020 20:56:45 +0100 (CET)
Date:   Fri, 27 Mar 2020 20:56:43 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm]
 ipc-mqueuec-change-__do_notify-to-bypass-check_kill_permission-fix
Message-ID: <20200327195643.GA9366@redhat.com>
References: <20200322110901.GA25108@redhat.com>
 <20200324200932.GB24230@redhat.com>
 <87v9mr1dlf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9mr1dlf.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26, Eric W. Biederman wrote:
>
> > +			task = pid_task(info->notify_owner, PIDTYPE_PID);
>                                                             ^^^^^^^^^^^^
> Minor nit:  If we are doing the task lookup ourselves that can and
>             should be PIDTYPE_TGID.

I think this shouldn't make any difference, in particular because
do_mq_notify() does "notify_owner = task_tgid()" and we do not care
about exec.

But I agree, pid_task(PIDTYPE_TGID) looks better, thanks.


diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 63b164932ffd..9a44dcb04e13 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -801,7 +801,7 @@ static void __do_notify(struct mqueue_inode_info *info)
 			 * bypass check_kill_permission(). It is from kernel
 			 * but si_fromuser() can't know this.
 			 */
-			task = pid_task(info->notify_owner, PIDTYPE_PID);
+			task = pid_task(info->notify_owner, PIDTYPE_TGID);
 			if (task)
 				do_send_sig_info(info->notify.sigev_signo,
 						&sig_i, task, PIDTYPE_TGID);

