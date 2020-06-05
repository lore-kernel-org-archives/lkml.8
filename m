Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A66C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8982067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgFETPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:15:15 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:39556 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbgFETPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:15:14 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 5 Jun 2020 12:15:10 -0700
Received: from akaher-virtual-machine.eng.vmware.com (unknown [10.197.103.239])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 35C76B008B;
        Fri,  5 Jun 2020 15:15:14 -0400 (EDT)
From:   Ajay Kaher <akaher@vmware.com>
To:     <fan_yang@sjtu.edu.cn>
CC:     <dan.j.williams@intel.com>, <kirill.shutemov@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <akaher@vmware.com>
Subject: Re: [PATCH v3] mm: Fix mremap not considering huge pmd devmap
Date:   Sat, 6 Jun 2020 00:44:36 +0530
Message-ID: <1591384476-31924-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <B9824572-C3C0-4D3B-88B8-D3A34D645653@sjtu.edu.cn>
References: <B9824572-C3C0-4D3B-88B8-D3A34D645653@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Fan, this scenario works to reproduce on v4.9.

And following fix works for v4.9:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-4.9.y&id=44cb51d5b4a736446b728bbde8407844d71843ef

-Ajay 

