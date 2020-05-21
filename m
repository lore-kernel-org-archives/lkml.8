Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F5E207C4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgEUAPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:15:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42330 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgEUAPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:15:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A4FDB2A2AFE
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     agk@redhat.com, snitzer@redhat.com, breeves@redhat.com,
        linux-kernel@vger.kernel.org, khazhy@google.com, song@kernel.org,
        dm-devel@redhat.com, mpatocka@redhat.com, kernel@collabora.com
Subject: Re: [dm-devel] [PATCH v4 0/2] Historical Service Time Path Selector
Organization: Collabora
References: <20200511163910.3778467-1-krisman@collabora.com>
        <ee987451-6d17-b978-809e-e0fe56dc13ce@gmail.com>
Date:   Wed, 20 May 2020 20:15:09 -0400
In-Reply-To: <ee987451-6d17-b978-809e-e0fe56dc13ce@gmail.com> (Xose Vazquez
        Perez's message of "Thu, 21 May 2020 01:26:27 +0200")
Message-ID: <85tv0am9de.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xose Vazquez Perez <xose.vazquez@gmail.com> writes:

> On 5/11/20 6:39 PM, Gabriel Krisman Bertazi wrote:
>
>> This fourth version of HST applies the suggestion from Mikulas Patocka
>> to do the ktime_get_ns inside the mpath map_bio instead of generic
>> device-mapper code. This means that struct dm_mpath_io gained another
>> 64bit field.  For the request-based case, we continue to use the block
>> layer start time information.
>
> You should add some info to the multipath.conf.5 man page (
> https://git.opensvc.com/gitweb.cgi?p=multipath-tools/.git;a=blob;f=multipath/multipath.conf.5;h=05a5e8ffeb110d969f3b2381eb3b88d7f28380f6;hb=HEAD#l189
> ),
> or none one is going to use it.

Sure, will do.

-- 
Gabriel Krisman Bertazi
