Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36795C5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1385521744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgLNaEPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgDSQcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:32:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32853 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726157AbgDSQcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587313951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVSecy80g6h7wXJCHuK830BzdD+TP99pr69Glv0B7sY=;
        b=YgLNaEPjVx3GE9vDRbq9SslzqvOnj4elY4RkZlJTb6/4fnb/L/16/3/1nqiFSCQRle1jkA
        iXd/6K87GD8DIfKi1WL1ctlvXvFs6T9TaABVjjpx7zmLvjrVoPbA17bGV+G6oJvKOeuWqW
        vIObHvHVniwe9SKWgfLd8tI3as35R8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-BvjPstCqNQK_S7N_aQ8Okw-1; Sun, 19 Apr 2020 12:32:25 -0400
X-MC-Unique: BvjPstCqNQK_S7N_aQ8Okw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 782D718C43C5;
        Sun, 19 Apr 2020 16:32:24 +0000 (UTC)
Received: from treble (ovpn-112-237.rdu2.redhat.com [10.10.112.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCB2B5DA76;
        Sun, 19 Apr 2020 16:32:22 +0000 (UTC)
Date:   Sun, 19 Apr 2020 11:32:19 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 3/7] objtool: Allow branches within the same
 alternative.
Message-ID: <20200419163219.b5dpg246xh6avsci@treble>
References: <20200416150752.569029800@infradead.org>
 <20200416151024.885221682@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416151024.885221682@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:07:55PM +0200, Peter Zijlstra wrote:
> From: Alexandre Chartre <alexandre.chartre@oracle.com>
> 
> Currently objtool prevents any branch to an alternative. While preventing
> branching from the outside to the middle of an alternative makes perfect
> sense, branching within the same alternative should be allowed. To do so,
> identify each alternative and check that a branch to an alternative comes
> from the same alternative.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200414103618.12657-3-alexandre.chartre@oracle.com

I I think I'd rather just drop this patch.  It adds some complexity and
I don't really see a benefit to having the warning in the first place.

Branching to the middle of an alternative group just doesn't seem like a
realistic scenario (can it even be done with the alternative macros?).

Even if it were possible, I'm not sure why somebody would attempt such a
feat.  And it seems like it would just wreck the system anyway.

-- 
Josh

