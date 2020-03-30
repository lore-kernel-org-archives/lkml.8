Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E7BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B40D206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFTc6ukA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgC3BFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:05:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38388 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727549AbgC3BFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585530337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RuVMi+yzQuqrWt1PfGiMDTX9P2hZ817ws+8wqAp5qk0=;
        b=OFTc6ukA9Eu7/YROBinqV8JEddEk1WV2Oz9uDpKOL0yj+KcrLuMnp6Ztxyt8ANy4QmN59z
        7CdVlf1taT9k7BG31u8hIh3Dy3g23Cg8bv1wZyfGgzW3JsRwVVWbVND6FFM8BlYfL4CEsZ
        g6tjNA9PKTSNl0ACLavVPW/vdNqMJYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-w4fOFj-WPMetl7R3dG9Hmw-1; Sun, 29 Mar 2020 21:05:35 -0400
X-MC-Unique: w4fOFj-WPMetl7R3dG9Hmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 211B1189F77A;
        Mon, 30 Mar 2020 01:05:34 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EED35C1BB;
        Mon, 30 Mar 2020 01:05:31 +0000 (UTC)
Date:   Mon, 30 Mar 2020 03:05:26 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Simran Singhal <singhalsimran0@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Add line after
 variable declarations
Message-ID: <20200330030526.7a1a3b9d@elisabeth>
In-Reply-To: <20200325164451.GA17569@simran-Inspiron-5558>
References: <20200325164451.GA17569@simran-Inspiron-5558>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simran,

On Wed, 25 Mar 2020 22:14:52 +0530
Simran Singhal <singhalsimran0@gmail.com> wrote:

> Add whiteline after variable declarations to remove the checkpatch.pl
> warning:
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>

Sorry for the late review. This patch introduces similar changes to the
other patches you posted to fix checkpatch warnings for rtl8723bs, so I
think they should be posted as a patchset instead.

-- 
Stefano

