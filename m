Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A1C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D7B20757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584792851;
	bh=nMDvRIWaBQEE07eBr/b8Z+twcpwniFZsKHyMXPtB6pw=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=QlwZ006K8xBv365Fnd791e5M/ngE9S+0SkEIcEy2KxeinVOfc/0nMsnbgWthA7097
	 BdINll55GqyhkmrU9s0NR3boVgA9/mwY6c9nuRqvdLjMwfdqaE3asg5FhVXCa69Aei
	 txTL6N1fuFExxGaeBmn2OeCmFzm/ogTNeupIVoIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCUMOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 08:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUMOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:14:09 -0400
Received: from [192.168.0.107] (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CBB20724;
        Sat, 21 Mar 2020 12:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584792848;
        bh=nMDvRIWaBQEE07eBr/b8Z+twcpwniFZsKHyMXPtB6pw=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=z8/oylr37/M67dJb6GRGSiB2TCdaqNVQovV9/U//Syw1i0IXQiSdKt9DKu4hgOce0
         EEOX/9zGcd6Heu38yyesU0w4A1KnPVDYNIXLIG9yO3rku2PiOXtHGVXaBN4VB8785i
         D49lAK1zHEIxYgMupX1OpoKfZhq2izG/ZhKRXu00=
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up f2fs_may_encrypt()
To:     Eric Biggers <ebiggers@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20200320101831.70611-1-yuchao0@huawei.com>
 <20200320190759.GK851@sol.localdomain>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
From:   Chao Yu <chao@kernel.org>
Message-ID: <14a40f93-d414-d475-56df-f07348db635b@kernel.org>
Date:   Sat, 21 Mar 2020 20:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200320190759.GK851@sol.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-3-21 3:07, Eric Biggers wrote:
> On Fri, Mar 20, 2020 at 06:18:31PM +0800, Chao Yu wrote:
>> Merge below two conditions into f2fs_may_encrypt() for cleanup
>> - IS_ENCRYPTED()
>> - DUMMY_ENCRYPTION_ENABLED()
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/dir.c   |  4 +---
>>  fs/f2fs/f2fs.h  | 13 +++++++++----
>>  fs/f2fs/namei.c |  4 +---
>>  3 files changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 0971ccc4664a..2accfc5e38d0 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -471,7 +471,6 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
>>  			struct page *dpage)
>>  {
>>  	struct page *page;
>> -	int dummy_encrypt = DUMMY_ENCRYPTION_ENABLED(F2FS_I_SB(dir));
>>  	int err;
>>
>>  	if (is_inode_flag_set(inode, FI_NEW_INODE)) {
>> @@ -498,8 +497,7 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
>>  		if (err)
>>  			goto put_error;
>>
>> -		if ((IS_ENCRYPTED(dir) || dummy_encrypt) &&
>> -					f2fs_may_encrypt(inode)) {
>> +		if (f2fs_may_encrypt(dir, inode)) {
>>  			err = fscrypt_inherit_context(dir, inode, page, false);
>>  			if (err)
>>  				goto put_error;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 09db79a20f8e..fcafa68212eb 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3946,15 +3946,20 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
>>  	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
>>  }
>>
>> -static inline bool f2fs_may_encrypt(struct inode *inode)
>> +static inline bool f2fs_may_encrypt(struct inode *dir, struct inode *inode)
>>  {
>>  #ifdef CONFIG_FS_ENCRYPTION
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>>  	umode_t mode = inode->i_mode;
>>
>> -	return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
>> -#else
>> -	return false;
>> +	/*
>> +	 * If the directory encrypted or dummy encryption enabled,
>> +	 * then we should encrypt the inode.
>> +	 */
>> +	if (IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi))
>> +		return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
>>  #endif
>> +	return false;
>>  }
>>
>>  static inline bool f2fs_may_compress(struct inode *inode)
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index b75c70813f9e..95cfbce062e8 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -75,9 +75,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>>
>>  	set_inode_flag(inode, FI_NEW_INODE);
>>
>> -	/* If the directory encrypted, then we should encrypt the inode. */
>> -	if ((IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) &&
>> -				f2fs_may_encrypt(inode))
>> +	if (f2fs_may_encrypt(dir, inode))
>>  		f2fs_set_encrypted_inode(inode);
>>
>>  	if (f2fs_sb_has_extra_attr(sbi)) {
>> --
>
> Can't f2fs_init_inode_metadata() just check IS_ENCRYPTED(inode) instead?
> (inode, not dir.)  The encrypt flag was already set by f2fs_new_inode(), right?

Correct, I've updated the patch.

Thanks,

>
> If so, then f2fs_may_encrypt() would only have one caller and it could be
> inlined into f2fs_new_inode(), similar to __ext4_new_inode().
>
> - Eric
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
