Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131D9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28D62072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCbZx2iY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHYOgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:36:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726542AbgHYOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598366168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1IisUIHcNO/OFv/dm0w7/44p361wqYjLF1qJ8vzlnk=;
        b=UCbZx2iYp/EYoChF98Dg87Co6cT2wWzXxc353b1Vb5Svkt60gAHvi9sjz9J2eQirWTvHtW
        ak7LiVH0LWKfGzMM0xyGdmTcQrvWTBDn6+c4fCy8Ly3D5iYs0dNo9VA0mHLe9ZrvRmKSZD
        InIUWmEz9U4txZ3/rX9wiCK9ga9KsYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-r34hJLdtNIqNDE17qz31Cw-1; Tue, 25 Aug 2020 10:36:04 -0400
X-MC-Unique: r34hJLdtNIqNDE17qz31Cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9A3810ABDC6;
        Tue, 25 Aug 2020 14:35:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E67660FC2;
        Tue, 25 Aug 2020 14:35:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 25 Aug 2020 16:35:59 +0200 (CEST)
Date:   Tue, 25 Aug 2020 16:35:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@suse.com, christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, adobriyan@gmail.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200825143548.GA28468@redhat.com>
References: <20200824153036.3201505-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824153036.3201505-1-surenb@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24, Suren Baghdasaryan wrote:
>
> v2:
> - Implemented proposal from Michal Hocko in:
> https://lore.kernel.org/linux-fsdevel/20200820124109.GI5033@dhcp22.suse.cz/
> - Updated description to reflect the change

Looks good to me,

Oleg.

