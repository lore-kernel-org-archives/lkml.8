Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D4AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71BC20721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQOLKMmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbgE1OJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:09:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57495 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390727AbgE1OJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590674962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=490niSUEjnok3sQJrwjS9wHcDf3r9lU64VwDtM9/LEk=;
        b=iQOLKMmgqf0EZjKhzNO/LYEnOnBfLVRiVbZG7P210eH5Ge/g9FNIotWV2hyNeaQ2UC2ZUA
        JFvlhDitswAO5I+QSWF0bEDVF49gzCELKBSDyQSR9C7cKqehpf5mlx98xaiY2LdseICrLn
        CMihawqIpoQM+wpVeA+3GxQPh4Gssus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-8a54KkNtNLe4i6WPLICf7w-1; Thu, 28 May 2020 10:09:20 -0400
X-MC-Unique: 8a54KkNtNLe4i6WPLICf7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D02181CBEF;
        Thu, 28 May 2020 14:09:19 +0000 (UTC)
Received: from treble (ovpn-117-65.rdu2.redhat.com [10.10.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D1315EE0E;
        Thu, 28 May 2020 14:09:18 +0000 (UTC)
Date:   Thu, 28 May 2020 09:09:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 2/3] objtool: Find relocation base section using
 sh_info
Message-ID: <20200528140916.6crguzfpehf6lext@treble>
References: <cover.1590597288.git.mhelsley@vmware.com>
 <d848189dac6c41193a6c55c3588b78114bbcb0f8.1590597288.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d848189dac6c41193a6c55c3588b78114bbcb0f8.1590597288.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:42:32AM -0700, Matt Helsley wrote:
> Currently objtool uses a naming heuristic to find the "base"
> section to apply the relocation(s) to. The standard defines
> the SHF_INFO_LINK flag (SHF => in the section header flags)
> which indicates when the section header's sh_info field can
> be used to find the necessary section.
> 
> Warns when the heuristic is used as a fallback and changes
> the name heuristic calculation to handle rela (explicit
> addend) and now rel (implicit addend) relocations.

Does this fallback case actually happen?

-- 
Josh

