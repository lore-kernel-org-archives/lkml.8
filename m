Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12985C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB13320409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCWHtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:49:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgCWHtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:49:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB401AC11;
        Mon, 23 Mar 2020 07:49:45 +0000 (UTC)
Subject: Re: [PATCH 2/2] evtchn: Change evtchn port type to evtchn_port_t
To:     Yan Yankovskyi <yyankovskyi@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200323053503.GA1406@kbp1-lhp-F74019>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <5b5c165b-aee3-7dde-f9f1-3a3de2e357a7@suse.com>
Date:   Mon, 23 Mar 2020 08:49:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323053503.GA1406@kbp1-lhp-F74019>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.2020 06:35, Yan Yankovskyi wrote:
> struct evtchn_set_priority uses uint32_t type for event channel port.
> Replace the type with evtchn_port_t. Such change is also done in Linux.
> 
> Signed-off-by: Yan Yankovskyi <yyankovskyi@gmail.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

As a general remark, the order of changes would better be the other way
around: The canonical header in the Xen repo be adjusted first, and the
change then propagated to repos carrying clones.

Thanks, Jan
