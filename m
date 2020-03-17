Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE4FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81F620724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCQK6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:58:39 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:34280 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbgCQK6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:58:36 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C050CB40064;
        Tue, 17 Mar 2020 10:58:34 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ukex01.SolarFlarecom.com
 (10.17.10.4) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Mar
 2020 10:58:29 +0000
Subject: Re: [PATCH] genirq: fix reference leaks on irq affinity notifiers
To:     Ben Hutchings <ben@decadent.org.uk>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <psodagud@codeaurora.org>
References: <24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com>
 <17c4273e4f72ebdf1ca838d75fc6ed93fcdc7287.camel@decadent.org.uk>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <a527a4bb-fdc4-815d-8852-674767b9dd1d@solarflare.com>
Date:   Tue, 17 Mar 2020 10:58:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <17c4273e4f72ebdf1ca838d75fc6ed93fcdc7287.camel@decadent.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1020-25296.003
X-TM-AS-Result: No-4.248500-8.000000-10
X-TMASE-MatchedRID: vbSD0OnL8/LmLzc6AOD8DfHkpkyUphL9TJDl9FKHbrkcNByoSo036QGH
        hjvYgYruPsXl2JSYAIEpCRJLmvqqi3ChPHB61wQjqa6SJk58+LZboh0Au8fxU44iwAQuovtYVCR
        qVeqou5MI4F3oGmhPwIFHACWsU4r11W2ugtS+qX+ar6Iu0UJj0pmuAlCliTSzXGA1P/YieHX6gA
        3qopxFX4LazLVRAcFWSAQzjYmjIgFglxYoDEUjbXYZxYoZm58FHkWa9nMURC7C5sPdIVtbO4JVW
        4oTDi/+Q+g1rftmMvDi7bnrXXW/P0vOGeNuCS0SryZo29uPUV41X1Ls767cpgytGucsJkSaU1LX
        qVLalgOmwYVyLbU23ImIDnzSS8mZthfZltvQe7Ic9jA4mLo8ueRjZuXE0WlH76DnE4yaaY9jaJH
        srxZyzJqDlcrjtNBeX7bicKxRIU2No+PRbWqfRK6NVEWSRWybcGT6u+1lSNQj6M1zoYhL94zlD6
        AoYogGa7Y6ULAxxP15pogVl0k5KmWRfS87Kq3ycWj1bBbZb7PG/oPzuc/KUXh0XsBsQXLjhXICX
        PkDTMLvGyaLyWJvBWLqcdF40kDywzhVZiqhieGz597RaJ+lCg==
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.248500-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1020-25296.003
X-MDID: 1584442715-7-UhaxvKdz29
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2020 20:29, Ben Hutchings wrote:
> ...since the pending work item holds a reference to the notification
> state, it's still not clear to me why or whether "genirq: Prevent use-
> after-free and work list corruption" was needed.
Yeah, I think that commit was bogus.  The email thread[1] doesn't
 exactly inspire confidence either.  I think the submitter just didn't
 realise that there was a ref corresponding to the work; AFAICT there's
 no way the alleged "work list corruption" could happen.

> If it's reasonable to cancel_work_sync() when removing a notifier, I
> think we can remove the kref and call the release function directly.
I'd prefer to stick to the smaller fix for -rc and stable.  But if you
 want to remove the kref for -next, I'd be happy to Ack that patch.


Btw, we (sfc linux team) think there's still a use-after-free issue in
 the cpu_rmap lib, as follows:
1) irq_cpu_rmap_add creates a glue and notifier, adds glue to rmap->obj
2) someone else does irq_set_affinity_notifier.
   This causes cpu_rmap's notifier (old_notify) to get released, and so
   irq_cpu_rmap_release kfrees glue.  But it's still in rmap->obj
3) free_irq_cpu_rmap loops over obj, finds the glue, tries to clear its
   notifier.
Now one could say that this UAF is academic, since having two bits of
 code trying to register notifiers for the same IRQ is broken anyway
 (in this case, the rmap would stop getting updated, because the
 "someone else" stole the notifier).
But I thought I'd bring it up in case it's halfway relevant.

-ed

[1] https://lore.kernel.org/lkml/1553119211-29761-1-git-send-email-psodagud@codeaurora.org/T/#u
