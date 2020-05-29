Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4168206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgE2Mq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:46:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36010 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Mq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:46:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeeP4-0002A8-13; Fri, 29 May 2020 06:46:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeeP3-0007XO-9w; Fri, 29 May 2020 06:46:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        axboe@kernel.dk, clemens@ladisch.de, arnd@arndb.de,
        gregkh@linuxfoundation.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20200529074108.16928-1-mcgrof@kernel.org>
        <20200529074108.16928-2-mcgrof@kernel.org>
        <87ftbiud6s.fsf@x220.int.ebiederm.org>
Date:   Fri, 29 May 2020 07:42:31 -0500
In-Reply-To: <87ftbiud6s.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 29 May 2020 07:40:27 -0500")
Message-ID: <878shaud3c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeeP3-0007XO-9w;;;mid=<878shaud3c.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Q4ZChrgvw1NHSy03cGUWR9nu5bHWud8U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 01/13] sysctl: add new register_sysctl_subdir() helper
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Luis Chamberlain <mcgrof@kernel.org> writes:
>
>> Often enough all we need to do is create a subdirectory so that
>> we can stuff sysctls underneath it. However, *if* that directory
>> was already created early on the boot sequence we really have no
>> need to use the full boiler plate code for it, we can just use
>> local variables to help us guide sysctl to place the new leaf files.
>>
>> So use a helper to do precisely this.
>
> Reset restart.  This is patch is total nonsense.
>
> - You are using register_sysctl_table which as I believe I have
>   mentioned is a deprecated compatibility wrapper.  The point of
>   spring house cleaning is to get off of the deprecated functions
>   isn't it?
>
> - You are using the old nasty form for creating directories instead
>   of just passing in a path.
>
> - None of this is even remotely necessary.  The directories
>   are created automatically if you just register their entries.

Oh.  *blink*  The poor naming threw me off.

This is a clumsy and poorly named version of register_sysctl();

Yes. This change is totally unnecessary.

Eric

