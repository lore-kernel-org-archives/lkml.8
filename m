Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4657C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C225520888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj27yMAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbgE1OFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:05:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390644AbgE1OFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590674699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zv5lW7u6pzvwevP8uffz5Bb9K/awBz9gIxRlqKaO8iE=;
        b=Qj27yMARbfYbW5m+L3WWyS5mJKSyRl0Z48u8Py5FfHdBnAG4QwnX8aSYi5SQ19k+Q3e2aV
        SKB0t6HOKG3jLrjnEMJSAFTQucPup4ZiU8UccENRph3F/bLiBKSSF8ky0XB3Zq4Z1Ql2Wf
        HBfzvAgvcsCDqZHzzWj1goSV7Czuam0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-wMS2tOAsO8SJrifHh1RQVg-1; Thu, 28 May 2020 10:04:57 -0400
X-MC-Unique: wMS2tOAsO8SJrifHh1RQVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96AA6ED7F3;
        Thu, 28 May 2020 14:04:46 +0000 (UTC)
Received: from treble (ovpn-117-65.rdu2.redhat.com [10.10.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D1A78B5A;
        Thu, 28 May 2020 14:04:45 +0000 (UTC)
Date:   Thu, 28 May 2020 09:04:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 1/3] objtool: Rename rela to reloc
Message-ID: <20200528140444.lgphq6sicir2l7ws@treble>
References: <cover.1590597288.git.mhelsley@vmware.com>
 <fcb4a18952604110296ade6f6e7331e165fe3382.1590597288.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcb4a18952604110296ade6f6e7331e165fe3382.1590597288.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:42:31AM -0700, Matt Helsley wrote:
> Before supporting additional relocation types rename the relevant
> types and functions from "rela" to "reloc". This work can largely
> be done with the following regex:
> 
> Notable exceptions include gelf_* library calls and
> standard/expected section names which still use "rela" because
> they encode the type of relocation expected. Also, keep "rela"
> in the struct because it encodes a specify type of relocation

Missing regex?

BTW it would be really nice if the regex were exact if possible, for
stable backporting reasons.

-- 
Josh

