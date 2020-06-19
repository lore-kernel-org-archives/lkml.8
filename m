Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03836C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD22208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392601AbgFSR3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:29:03 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48044 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgFSR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:29:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmKp2-0001N7-BM; Fri, 19 Jun 2020 11:29:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmKp1-0004bC-7P; Fri, 19 Jun 2020 11:29:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
        <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
        <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
        <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
Date:   Fri, 19 Jun 2020 12:24:41 -0500
In-Reply-To: <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com> (Junxiao Bi's
        message of "Fri, 19 Jun 2020 08:56:21 -0700")
Message-ID: <87k1036k9y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmKp1-0004bC-7P;;;mid=<87k1036k9y.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18t/kZAHYChf4fQBy2tfa9zm0fEa/HZ2QQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Junxiao Bi <junxiao.bi@oracle.com> writes:

> Hi Eric,
>
> The patch didn't improve lock contention.

Which raises the question where is the lock contention coming from.

Especially with my first variant.  Only the last thread to be reaped
would free up anything in the cache.

Can you comment out the call to proc_flush_pid entirely?

That will rule out the proc_flush_pid in d_invalidate entirely.

The only candidate I can think of d_invalidate aka (proc_flush_pid) vs ps.

Eric
