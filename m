Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F208C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AEB20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnYaxXVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbgAXQ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:26:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52005 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388131AbgAXQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579883183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iP5kUzj/MjjYp8gqP+NZWwU5OGdgr2jRpmH4EARLI/g=;
        b=QnYaxXVB92QAsAYYgMSMit1XPfVsmivPPskolfKCSYbOu2yChZvLnzyUiHh1dueDdWntFN
        4dMBg7b/LRyIFgbmO4CbA3lpU9c+v2PJOuN4Qh7uMDoJyAngo/L3ZDTkJ1EMXFUXuFFU5u
        p4LWYR5XurcQ/pjpCqwCrZ+zMY6mYYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-KqwGgzqlMdit2ebtrV91vQ-1; Fri, 24 Jan 2020 11:26:18 -0500
X-MC-Unique: KqwGgzqlMdit2ebtrV91vQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A40C109576C;
        Fri, 24 Jan 2020 16:26:17 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1676010016E8;
        Fri, 24 Jan 2020 16:26:15 +0000 (UTC)
Subject: Re: [PATCH 7/7] sysvipc_find_ipc should increase position index
To:     Vasily Averin <vvs@virtuozzo.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
References: <b7a20945-e315-8bb0-21e6-3875c14a8494@virtuozzo.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8ed2850e-7cec-ebeb-4e15-21da3715c42a@redhat.com>
Date:   Fri, 24 Jan 2020 11:26:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b7a20945-e315-8bb0-21e6-3875c14a8494@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/20 2:03 AM, Vasily Averin wrote:
> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  ipc/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ipc/util.c b/ipc/util.c
> index 915eacb..7a3ab2e 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -764,13 +764,13 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>  			total++;
>  	}
>  
> +	*new_pos = pos + 1;
>  	if (total >= ids->in_use)
>  		return NULL;
>  
>  	for (; pos < ipc_mni; pos++) {
>  		ipc = idr_find(&ids->ipcs_idr, pos);
>  		if (ipc != NULL) {
> -			*new_pos = pos + 1;
>  			rcu_read_lock();
>  			ipc_lock_object(ipc);
>  			return ipc;

Acked-by: Waiman Long <longman@redhat.com>

