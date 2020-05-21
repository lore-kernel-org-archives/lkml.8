Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7488CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FEA20738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TD2fDeKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEUGs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEUGs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:48:28 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E72AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:48:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49SKvV6hDcz9sT9;
        Thu, 21 May 2020 16:48:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590043704;
        bh=mylN82RMn5av9mlUtP03Bq7JN7H0txBfw8gjg+ZMQ7s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TD2fDeKCARBDrWHY+VsGAe2iNnjSqQg60E3P1g7BHV/e9JoUek2xU6OXtkwdaFBlG
         aGsN7rfCMbH628gOSdZXEoRypdxmeNdDtrpbG4z8i41l8g31J3EgJqZna48GJKwC2D
         5bRYia+7Z03muiVkvkWqj3ePOGlgXK0kW3acfngvbgMdQClEMJRRQ5Z8x3nV+qRPyX
         EraBdtFn9TliOy7sS163c8RGPhBZnu6NStAC3CIu4NHNsMKW+KtIsGQQxbHCcvH6dx
         4yVgcFUs0HZ2rGH7IcJSH/rK0vExeIUOkgCbyQhjDX2DlL14cZeT9FW4/IsS3D9Hip
         vvOPM4L7nSzmA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ira Weiny <ira.weiny@intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RESEND PATCH v7 4/5] ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
In-Reply-To: <20200520153209.GC3660833@iweiny-DESK2.sc.intel.com>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com> <20200519190058.257981-5-vaibhav@linux.ibm.com> <20200520153209.GC3660833@iweiny-DESK2.sc.intel.com>
Date:   Thu, 21 May 2020 16:48:40 +1000
Message-ID: <87367t941j.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny <ira.weiny@intel.com> writes:
> On Wed, May 20, 2020 at 12:30:57AM +0530, Vaibhav Jain wrote:
>> Introduce support for Papr nvDimm Specific Methods (PDSM) in papr_scm
>> modules and add the command family to the white list of NVDIMM command
>> sets. Also advertise support for ND_CMD_CALL for the dimm
>> command mask and implement necessary scaffolding in the module to
>> handle ND_CMD_CALL ioctl and PDSM requests that we receive.
...
>> + *
>> + * Payload Version:
>> + *
>> + * A 'payload_version' field is present in PDSM header that indicates a specific
>> + * version of the structure present in PDSM Payload for a given PDSM command.
>> + * This provides backward compatibility in case the PDSM Payload structure
>> + * evolves and different structures are supported by 'papr_scm' and 'libndctl'.
>> + *
>> + * When sending a PDSM Payload to 'papr_scm', 'libndctl' should send the version
>> + * of the payload struct it supports via 'payload_version' field. The 'papr_scm'
>> + * module when servicing the PDSM envelope checks the 'payload_version' and then
>> + * uses 'payload struct version' == MIN('payload_version field',
>> + * 'max payload-struct-version supported by papr_scm') to service the PDSM.
>> + * After servicing the PDSM, 'papr_scm' put the negotiated version of payload
>> + * struct in returned 'payload_version' field.
>
> FWIW many people believe using a size rather than version is more sustainable.
> It is expected that new payload structures are larger (more features) than the
> previous payload structure.
>
> I can't find references at the moment through.

I think clone_args is a good modern example:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sched.h#n88

cheers
