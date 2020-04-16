Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D2C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0457B20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzxCiZg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgDPQUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:20:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726362AbgDPQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587054033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4rkdFZCt+CYPzp3/Qg70/GCXwWzZ5opTjJmcpHVXJY=;
        b=TzxCiZg++1RNG9Kzqtv7aijYb8fto828VpPdoA09O7Ya8jOCL1KfhfoyCop+gh54HGDbwz
        j1KREuJLS1lDZc5o9Eo3t4s/Q31yFD+u1+QFkXwQDXis5uWPX/DWlOym7fR17nFNHQe6jJ
        TRtuVM6hhp62ns4cwJtjQCT31DVzZOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-ahS35uOiO1aiRJMy7kongw-1; Thu, 16 Apr 2020 12:20:29 -0400
X-MC-Unique: ahS35uOiO1aiRJMy7kongw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 181ED8F297B;
        Thu, 16 Apr 2020 16:20:17 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-72.rdu2.redhat.com [10.10.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D07AB6025E;
        Thu, 16 Apr 2020 16:20:14 +0000 (UTC)
Subject: Re: WARNING in kernfs_new_node
To:     syzbot <syzbot+499aea72daa2cea73cb7@syzkaller.appspotmail.com>,
        benh@kernel.crashing.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
References: <00000000000066c5a605a366e88c@google.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <db670b70-8ed9-94d5-6492-622a8e0bf28b@redhat.com>
Date:   Thu, 16 Apr 2020 12:20:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <00000000000066c5a605a366e88c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: locking/lockdep: Reuse freed chain_hlocks entries

