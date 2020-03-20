Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33064C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0987F20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCTLFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:05:46 -0400
Received: from mail.wangsu.com ([123.103.51.198]:38769 "EHLO wangsu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbgCTLFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:05:45 -0400
X-Greylist: delayed 102766 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 07:05:43 EDT
Received: from XMCDN1207038 (unknown [59.61.78.137])
        by app1 (Coremail) with SMTP id xjNnewB3fgpgo3RejKAaAA--.0S2;
        Fri, 20 Mar 2020 19:05:05 +0800 (CST)
From:   "Pengcheng Yang" <yangpc@wangsu.com>
To:     "'Andrew Morton'" <akpm@linux-foundation.org>
Cc:     <gregkh@linuxfoundation.org>, <jannh@google.com>,
        <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>
References: <1579691175-28949-1-git-send-email-yangpc@wangsu.com> <20200123172321.0ef6744e784692585f9843b3@linux-foundation.org>
In-Reply-To: <20200123172321.0ef6744e784692585f9843b3@linux-foundation.org>
Subject: Re: [PATCH RESEND] kernel/relay.c: fix read_pos error when multiple readers
Date:   Fri, 20 Mar 2020 19:04:42 +0800
Message-ID: <000301d5fea7$5c032080$14096180$@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGPVR6qrpR+TkJwCkoxrhWdu69gOQGyL5EXqNEJ7fA=
Content-Language: zh-cn
X-CM-TRANSID: xjNnewB3fgpgo3RejKAaAA--.0S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7tF4fJFyrZrWDCr17KFg_yoWrGw1UpF
        Z3Cw4Fyr4kWrZ5AFWxAF4vvryfCaykXF47JrWIqa4UJw129rnYyFWfJw4YyrW8GrWF93yj
        gr4Utwn8JFsrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyvb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vE
        x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Gr4l
        Yx0Ec7CjxVAajcxG14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUb8pnPUUUUU==
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 9:23:26 +0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> On Wed, 22 Jan 2020 19:06:15 +0800 Pengcheng Yang <yangpc@wangsu.com> wrote:
> 
> > When reading, read_pos should start with bytes_consumed,
> > not file->f_pos. Because when there is more than one reader,
> > the read_pos corresponding to file->f_pos may have been consumed,
> > which will cause the data that has been consumed to be read
> > and the bytes_consumed update error.
> 
> That sounds fairly serious.  Are you able to describe a userspace setup
> which will trigger this?  Do you have any test code which is able to
> demonstrate the bug?
> 
> We really should have a relay testcase in tools/testing, but relay came
> along before we became diligent about this.


Thanks for following this case!

The problem is that Relay uses the file->f_pos associated with 
the process to read the buffer, and adds the number of bytes read 
to rchan_buf->bytes_consumed.

Here is a simple test case, the kernel module relay_test writes 
the string "12345678" in module_init through relay_write; 
the relay_read program uses two processes to alternately 
read 2 bytes from Relay.
It shows that process A reads the string "34" that has been 
consumed by process B, and the string "56" may be skipped next.


========
Module relay_test:

#include <linux/module.h>
#include <linux/relay.h>
#include <linux/debugfs.h>

static struct rchan *chan = NULL;
static struct dentry *dir = NULL;

static size_t subbuf_size = 512;
static int n_subbufs = 32;

static struct dentry *create_buf_file_handler(const char *filename,
					      struct dentry *parent,
					      umode_t mode,
					      struct rchan_buf *buf,
					      int *is_global)
{
	return debugfs_create_file(filename, mode, parent, buf,
				   &relay_file_operations);
}

static int remove_buf_file_handler(struct dentry *dentry)
{
	debugfs_remove(dentry);
	return 0;
}

static struct rchan_callbacks relay_callbacks = {
	.create_buf_file = create_buf_file_handler,
	.remove_buf_file = remove_buf_file_handler,
};

static int relay_init(void)
{
	dir = debugfs_create_dir("relay_test", NULL);
	if (!dir)
		goto err;

	chan = relay_open("cpu", dir, subbuf_size, n_subbufs, &relay_callbacks, NULL);
	if (!chan) {
		debugfs_remove(dir);
		goto err;
	}
	
	relay_write(chan, "12345678", 9);

	return 0;
err:
	return -EFAULT;
}
	
static void relay_exit(void)
{
	relay_close(chan);
	debugfs_remove(dir);
}

module_init(relay_init);
module_exit(relay_exit);


========
Program relay_read:

#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>  
#include <sys/types.h>  

int main(void)
{
	int pa[2], pb[2];
	char buf[16], buf_r[16] = {0};
	pid_t pid;

	if (pipe(pa) || pipe(pb))
		return -1;

	if ((pid = fork()) < 0) {
		return -2;
	} else if (pid > 0) { /* process A */
		int relay_fd = open("/sys/kernel/debug/relay_test/cpu0", O_RDONLY);
		if (relay_fd < 0)
			return -1;
		close(pa[0]);
		close(pb[1]);

		/* expect to read "12" */
		read(relay_fd, buf_r, 2);
		printf("process A: read from relay %s\n", buf_r);

		write(pa[1], "w", 2); /* wake up process B */
		read(pb[0], buf, 256); /* wait */

		/* BUG: expect to read "56"
		 * actually read "34" which is already consumed
		 */
		read(relay_fd, buf_r, 2);
		printf("process A: read from relay %s\n", buf_r);

	} else { /* process B */
		int relay_fd = open("/sys/kernel/debug/relay_test/cpu0", O_RDONLY);
		if (relay_fd < 0)
			return -1;
		close(pa[1]);
		close(pb[0]);

		read(pa[0], buf, 256); /* wait */

		/* expect to read "34" */
		read(relay_fd, buf_r, 2);
		printf("process B: read from relay %s\n", buf_r);

		write(pb[1], "w", 2); /* wake up process A */
	}

	return 0;
}


========
Here is runing the test:

# taskset -c 0 insmod relay_test.ko
# ./relay_read 
process A: read from relay 12
process B: read from relay 34
process A: read from relay 34
# cat /sys/kernel/debug/relay_test/cpu0
78

