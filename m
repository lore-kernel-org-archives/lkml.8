Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FF7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6006920663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0EuWrTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgCXTL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:11:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37126 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727715AbgCXTL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585077116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWa3hFcJfMHl7V5fCeCQBW+Qo+00+itJrJJVYsrBbg8=;
        b=X0EuWrTyNhAISlqhNCKke8f62K/ozcNSSX0tAGTvjt8B+hqMMvjO5S4SeJj1Nk83UFadjF
        udV5NSDFnmi8OftMAj1jQHfbsDKci8vB8Si90+LAs8zPBmCI9vOtRRgYCTeGiXksGtPTzg
        Cx8gn4VYV2ThL+1+Ccp1I2RZy7WiVag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-cmfqhujuOge-VqRkcub2_w-1; Tue, 24 Mar 2020 15:11:54 -0400
X-MC-Unique: cmfqhujuOge-VqRkcub2_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21A89800D5C;
        Tue, 24 Mar 2020 19:11:53 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4871660BF3;
        Tue, 24 Mar 2020 19:11:50 +0000 (UTC)
Date:   Tue, 24 Mar 2020 15:11:49 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        dm-devel <dm-devel@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2] dm-integrity: Prevent RMW for full metadata buffer
 writes
Message-ID: <20200324191148.GA2921@redhat.com>
References: <20200227142601.61f3cd54@luklap>
 <20200324171821.GA2444@redhat.com>
 <20200324195912.518dc87c@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324195912.518dc87c@luklap>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24 2020 at  2:59pm -0400,
Lukas Straub <lukasstraub2@web.de> wrote:

> On Tue, 24 Mar 2020 13:18:22 -0400
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > On Thu, Feb 27 2020 at  8:26am -0500,
> > Lukas Straub <lukasstraub2@web.de> wrote:
> > 
> > > If a full metadata buffer is being written, don't read it first. This
> > > prevents a read-modify-write cycle and increases performance on HDDs
> > > considerably.
> > > 
> > > To do this we now calculate the checksums for all sectors in the bio in one
> > > go in integrity_metadata and then pass the result to dm_integrity_rw_tag,
> > > which now checks if we overwrite the whole buffer.
> > > 
> > > Benchmarking with a 5400RPM HDD with bitmap mode:
> > > integritysetup format --no-wipe --batch-mode --interleave-sectors $((64*1024)) -t 4 -s 512 -I crc32c -B /dev/sdc
> > > integritysetup open --buffer-sectors=1 -I crc32c -B /dev/sdc hdda_integ
> > > dd if=/dev/zero of=/dev/mapper/hdda_integ bs=64K count=$((16*1024*4)) conv=fsync oflag=direct status=progress
> > > 
> > > Without patch:
> > > 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 400.326 s, 10.7 MB/s
> > > 
> > > With patch:
> > > 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 41.2057 s, 104 MB/s
> > > 
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > > Hello Everyone,
> > > So here is v2, now checking if we overwrite a whole metadata buffer instead
> > > of the (buggy) check if we overwrite a whole tag area before.
> > > Performance stayed the same (with --buffer-sectors=1).
> > > 
> > > The only quirk now is that it advertises a very big optimal io size in the
> > > standard configuration (where buffer_sectors=128). Is this a Problem?
> > > 
> > > v2:
> > >  -fix dm_integrity_rw_tag to check if we overwrite a whole metadat buffer
> > >  -fix optimal io size to check if we overwrite a whole metadata buffer
> > > 
> > > Regards,
> > > Lukas Straub  
> > 
> > 
> > Not sure why you didn't cc Mikulas but I just checked with him and he
> > thinks:
> > 
> > You're only seeing a boost because you're using 512-byte sector and
> > 512-byte buffer. Patch helps that case but hurts in most other cases
> > (due to small buffers).
> 
> Hmm, buffer-sectors is still user configurable. If the user wants fast
> write performance on slow HDDs he can set a small buffer-sector and
> benefit from this patch. With the default buffer-sectors=128 it
> shouldn't have any impact.

OK, if you'd be willing to conduct tests to prove there is no impact
with larger buffers that'd certainly help reinforce your position and
make it easier for me to take your patch.

But if you're just testing against slow HDD testbeds then the test
coverage isn't wide enough.

Thanks,
Mike

