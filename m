Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE4BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D9B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGMSmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:42:46 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49670 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgGMSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:42:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jv3PU-0007mD-OF; Mon, 13 Jul 2020 12:42:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jv3PR-0001ur-HK; Mon, 13 Jul 2020 12:42:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matt Bennett <Matt.Bennett@alliedtelesis.co.nz>
Cc:     "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "zbr\@ioremap.net" <zbr@ioremap.net>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
References: <20200702002635.8169-1-matt.bennett@alliedtelesis.co.nz>
        <87k0zlspxs.fsf@x220.int.ebiederm.org>
        <94defa61204731d7dce37edeb98069c8647722c2.camel@alliedtelesis.co.nz>
Date:   Mon, 13 Jul 2020 13:39:48 -0500
In-Reply-To: <94defa61204731d7dce37edeb98069c8647722c2.camel@alliedtelesis.co.nz>
        (Matt Bennett's message of "Sun, 5 Jul 2020 22:31:25 +0000")
Message-ID: <87lfjn9s3v.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jv3PR-0001ur-HK;;;mid=<87lfjn9s3v.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+bSAA2WjgwsAy+DqUrSJ23WR2oUHPLg1M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/5] RFC: connector: Add network namespace awareness
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bennett <Matt.Bennett@alliedtelesis.co.nz> writes:

> On Thu, 2020-07-02 at 13:59 -0500, Eric W. Biederman wrote:
>> Matt Bennett <matt.bennett@alliedtelesis.co.nz> writes:
>> 
>> > Previously the connector functionality could only be used by processes running in the
>> > default network namespace. This meant that any process that uses the connector functionality
>> > could not operate correctly when run inside a container. This is a draft patch series that
>> > attempts to now allow this functionality outside of the default network namespace.
>> > 
>> > I see this has been discussed previously [1], but am not sure how my changes relate to all
>> > of the topics discussed there and/or if there are any unintended side
>> > effects from my draft
>> 
>> In a quick skim this patchset does not look like it approaches a correct
>> conversion to having code that works in multiple namespaces.
>> 
>> I will take the changes to proc_id_connector for example.
>> You report the values in the callers current namespaces.
>> 
>> Which means an unprivileged user can create a user namespace and get
>> connector to report whichever ids they want to users in another
>> namespace.  AKA lie.
>> 
>> So this appears to make connector completely unreliable.
>> 
>> Eric
>> 
>
> Hi Eric,
>
> Thank you for taking the time to review. I wrote these patches in an
> attempt to show that I was willing to do the work myself rather than
> simply asking for someone else to do it for me. The changes worked for
> my use cases when I tested them, but I expected that some of the
> changes would be incorrect and that I would need some guidance. I can
> spend some time to really dig in and fully understand the changes I am
> trying to make (I have limited kernel development experience) but
> based on the rest of the discussion threads it seems that there is
> likely no appetite to ever support namespaces with the connector.

Good approach to this.

My sense is that there are few enough uses of connector that if don't
mind changing your code so that it works in a container (and the pidfd
support appears to already provide what you need) that is probably the
past of least resistance.

I don't think it maintaining connector support would be much more work
than it is now, if someone went through and did the work to carefully
convert the code.  So if someone really wants to use connector we can
namespace the code.

Otherwise it is probably makes sense to let the few users gradually stop
using connector so the code can eventually be removed.

Please checkout out the pidfd support and tell us how it meets your
needs.  If there is something that connector really does better it would
be good to know.

Thank you,
Eric
