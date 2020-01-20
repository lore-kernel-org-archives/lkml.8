Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20525C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84702070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgATPMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:12:55 -0500
Received: from winds.org ([68.75.195.9]:44646 "EHLO winds.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgATPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:12:55 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2020 10:12:54 EST
Received: by winds.org (Postfix, from userid 100)
        id A14705561B9; Mon, 20 Jan 2020 10:03:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by winds.org (Postfix) with ESMTP id 9ED7628F44;
        Mon, 20 Jan 2020 10:03:27 -0500 (EST)
Date:   Mon, 20 Jan 2020 10:03:27 -0500 (EST)
From:   Byron Stanoszek <gandalf@winds.org>
To:     jeffm@suse.com
cc:     linux-kernel@vger.kernel.org
Subject: Re: reiserfs broke between 4.9.205 and 4.9.208
Message-ID: <alpine.LNX.2.21.1.2001200956220.14639@winds.org>
User-Agent: Alpine 2.21.1 (LNX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020, Jeff Mahoney wrote:
>On 1/9/20 7:12 AM, Jan Kara wrote:
>>
>> Hello,
>>
>> On Wed 08-01-20 15:42:58, Randy Dunlap wrote:
>>> On 1/8/20 11:36 AM, Michael Brunnbauer wrote:
>>>> after upgrading from 4.9.205 to 4.9.208, I get errors on two different
>>>> reiserfs filesystems when doing cp -a (the chown part seems to fail) and
>>>> on other occasions:
>>>>
>>>>  kernel: REISERFS warning (device sda1): jdm-20004 reiserfs_delete_xattrs: Couldn't delete all xattrs (-95)
>>>>
>>>>  kernel: REISERFS warning (device sdc1): jdm-20004 reiserfs_delete_xattrs: Couldn't delete all xattrs (-95)
>>>>
>>>> This behaviour disappeared after a downgrade to 4.9.205.
>>>>
>>>> I understand there have been changes to the file system code but I'm not
>>>> sure they affect reiserfs, e.g.
>>>>
>>>>  https://bugzilla.kernel.org/show_bug.cgi?id=205433
>>>>
>>>> Any Idea?
>>>>
>>>> Regards,
>>>>
>>>> Michael Brunnbauer
>>>>
>>>
>>> Looks to me like 4.9.207 contains reiserfs changes.
>>>
>>> Adding CC's.
>>
>> Looks like a regression from commit 60e4cf67a582 "reiserfs: fix extended
>> attributes on the root directory". We are getting -EOPNOTSUPP from
>> reiserfs_for_each_xattr() likely originally from open_xa_root(). Previously
>> we were returning -ENODATA from there which error reiserfs_for_each_xattr()
>> converted to 0. I don't understand reiserfs xattrs enough to quickly tell
>> what should actually be happening after the Jeff's change - naively I'd
>> think we should just silence the bogus warning in case of EOPNOTSUPP. Jeff,
>> can you have a look?
>>
>> Also Michael, I'd like to clarify: Does 'cp -a' return any error or is it
>> just that the kernel is spewing these annoying warnings?  Because from the
>> code reading I'd think that it is only the kernel spewing errors but
>> userspace should be fine...
>
>This error occurs when extended attributes are not enabled on the file
>system *and* the module is not built with extended attributes enabled.
>I've sent out the fix for it just now.
>
>-Jeff

Hi Jeff,

Can you share the patch with us for testing? I haven't seen this hit mainline
yet.

Thanks,
  -Byron

