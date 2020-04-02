Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0FFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3934220757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emIaEi5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgDBRRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:17:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgDBRRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585847861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pgwzq6dRSIzB79LHGPXWqG3p9VMpBWq56L/q1J1BvfE=;
        b=emIaEi5L5LdTNYlWjOlQd4V99803T6vr7aGOg2xmm3Cxgh/OJTKRiZkX2VRpYSuRPUvWzV
        MWFuEBaul+8v8CENKNqiV0aKfJvXJMFmUMCzN8VU0iRFlc+jfzmASbJFc9H4gYl1PyvMXs
        PKc4niavVACVjBkGecP18jB+kIftfZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-qIqYi7KKN4mzO1JRZZYeEQ-1; Thu, 02 Apr 2020 13:17:40 -0400
X-MC-Unique: qIqYi7KKN4mzO1JRZZYeEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2079F800D5C;
        Thu,  2 Apr 2020 17:17:39 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7138792FAD;
        Thu,  2 Apr 2020 17:17:38 +0000 (UTC)
Date:   Thu, 2 Apr 2020 12:17:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        raphael.gault@arm.com
Subject: Re: [PATCH v2 01/10] objtool: Move header sync-check ealier in build
Message-ID: <20200402171736.4d3znydfxp37ovzb@treble>
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-2-jthierry@redhat.com>
 <20200402171234.mbvusm7esqgydpz3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402171234.mbvusm7esqgydpz3@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 12:12:37PM -0500, Josh Poimboeuf wrote:
> On Fri, Mar 27, 2020 at 03:28:38PM +0000, Julien Thierry wrote:
> > Currently, the check of tools files against kernel equivalent is only
> > done after every object file has been built. This means one might fix
> > build issues against outdated headers without seeing a warning about
> > this.
> 
> s/ealier/earlier/ in $SUBJECT

Actually don't worry about fixing that up, after my review I'll take
this patch (and any other trivial ones) and do any trivial cleanups like
that and then forward them along to the tip tree.

-- 
Josh

