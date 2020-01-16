Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E760C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F04F207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEQ6E77x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgAPOid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:38:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49859 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgAPOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579185511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ywzTMlHkadj5tzI8BE77qjkKOHJ7vdRzglAKCzUZs+o=;
        b=GEQ6E77x3rFTDaMokOFVNOuIrZQszpzIDd3yojJb5bTneIfX+VXn4pps+AHqCJDxKsh8d1
        2IDQG30EpXPuGIH2gm4dPwuuzBBViFZ03wKkpN+rfQRjiHK33l9qTf/RjbwGuA1z88e2bp
        J4UXYakCWqY+aripZIVnQwxcRCum4kI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-kj7OR4WFOwisucsD14FLEQ-1; Thu, 16 Jan 2020 09:38:27 -0500
X-MC-Unique: kj7OR4WFOwisucsD14FLEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6185800D48;
        Thu, 16 Jan 2020 14:38:25 +0000 (UTC)
Received: from treble (ovpn-121-224.rdu2.redhat.com [10.10.121.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4825E8889C;
        Thu, 16 Jan 2020 14:38:24 +0000 (UTC)
Date:   Thu, 16 Jan 2020 08:38:22 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/cpu: Update cached HLE state on write to
 TSX_CTRL_CPUID_CLEAR
Message-ID: <20200116143822.ffunlqsboxkvsv4x@treble>
References: <2529b99546294c893dfa1c89e2b3e46da3369a59.1578685425.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2529b99546294c893dfa1c89e2b3e46da3369a59.1578685425.git.pawan.kumar.gupta@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 02:50:54PM -0800, Pawan Gupta wrote:
> /proc/cpuinfo currently reports Hardware Lock Elision (HLE) feature to
> be present on boot cpu even if it was disabled during the bootup. This
> is because cpuinfo_x86->x86_capability HLE bit is not updated after TSX
> state is changed via a new MSR IA32_TSX_CTRL.
> 
> Update the cached HLE bit also since it is expected to change after an
> update to CPUID_CLEAR bit in MSR IA32_TSX_CTRL.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

