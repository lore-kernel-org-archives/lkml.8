Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D51C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8402B2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGQCW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:22:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:37358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgGQCWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:22:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82EB3AB76;
        Fri, 17 Jul 2020 02:22:26 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuyongqiang13@huawei.com
References: <20200716090313.13216-1-miaoqinglang@huawei.com>
 <a0f9b92b-d8f2-7c03-8c48-9e71e506361b@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Subject: Re: [PATCH -next] bcache: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <639a9561-2824-b668-42b3-b69f016f54e1@suse.de>
Date:   Fri, 17 Jul 2020 10:22:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a0f9b92b-d8f2-7c03-8c48-9e71e506361b@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/16 17:54, Coly Li wrote:
> On 2020/7/16 17:03, Qinglang Miao wrote:
>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>
> 
> Hi Qianlang and Yongqiang,
> 
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> ---
>>  drivers/md/bcache/closure.c | 16 +++-------------
>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
>> index 99222aa5d..37b9c5d49 100644
>> --- a/drivers/md/bcache/closure.c
>> +++ b/drivers/md/bcache/closure.c
>> @@ -159,7 +159,7 @@ void closure_debug_destroy(struct closure *cl)
>>  
>>  static struct dentry *closure_debug;
>>  
>> -static int debug_seq_show(struct seq_file *f, void *data)
>> +static int debug_show(struct seq_file *f, void *data)
>>  {
>>  	struct closure *cl;
>>  
>> @@ -188,17 +188,7 @@ static int debug_seq_show(struct seq_file *f, void *data)
>>  	return 0;
>>  }
>>  
>> -static int debug_seq_open(struct inode *inode, struct file *file)
>> -{
>> -	return single_open(file, debug_seq_show, NULL);
>> -}
>> -
> 
> Here NULL is sent to single_open(), in DEFINE_SHOW_ATTRIBUTE()
> inode->i_private is sent into single_open(). I don't see the commit log
> mentions or estimates such change.
> 

Still this change modifies original code logic, I need to know the exact
effect before taking this patch.

> 
>> -static const struct file_operations debug_ops = {
>> -	.owner		= THIS_MODULE,
>> -	.open		= debug_seq_open,
>> -	.read_iter		= seq_read_iter,
> 
> I doubt this patch applies to Linux v5.8-rc, this is how debug_ops is
> defined in Linux v5.8-rc5,
>

I realize your patch is against linux-next, which is ahead of both
linux-block and mainline tree. So this patch does not apply to
linux-block tree, which is my upstream for bcache going to upstream.

I suggest to generate the patch against latest mainline kernel, or
linux-block branch for next merge window (for 5.9 it is branch
remotes/origin/for-5.9/drivers).


> 196 static const struct file_operations debug_ops = {
> 197         .owner          = THIS_MODULE,
> 198         .open           = debug_seq_open,
> 199         .read           = seq_read,
> 200         .release        = single_release
> 201 };
> 
>> -	.release	= single_release
>> -};
>> +DEFINE_SHOW_ATTRIBUTE(debug);
>>  
>>  void  __init closure_debug_init(void)
>>  {
>> @@ -209,7 +199,7 @@ void  __init closure_debug_init(void)
>>  		 * about this.
>>  		 */
>>  		closure_debug = debugfs_create_file(
>> -			"closures", 0400, bcache_debug, NULL, &debug_ops);
>> +				"closures", 0400, bcache_debug, NULL, &debug_fops);
>>  }
>>  #endif
> 
> Do you test your change with upstream kernel ? Or at least you should
> try to apply and compile the patch with latest upstream kernel.

I withdraw the above wrong word, the -next tag in patch subject was
overlooked by me. Next time I will try to avoid such mistake.

Coly Li


