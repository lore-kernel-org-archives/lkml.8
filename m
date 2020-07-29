Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1370C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9996F2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rWTvH4oD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgG2PPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:15:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35504 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2PPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:15:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TFCENR009733;
        Wed, 29 Jul 2020 15:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UPqSeT4M9c7oQDxJEUOwhRdpMxfoY17GZ1KRplSx+ek=;
 b=rWTvH4oDq0oH2th6KbZ1H2Pn7upclNttfotj5PznjaIbBiCJwTxo1Fhy+eZfql805YFK
 YP7UtE87M793AJHD6bXEMKcsqxhe59U1S0babEDD1sepiO5ozGkLkH18SvHXuFkyqv2Z
 D/dVw65lxayL7sydbVjtcn3u3BbtJfI4HMOcKjTW73bXsM/aNMvHNnJl60yNxDKRaFIe
 HNeJLKbItaXf9v4VWyHFAA7PHpDmBDA1q+BKoZLtuyvf+arjnWCVWyRVcGTXRjP8dSsn
 l/xdM6oeVyc5ZseGCYthko+syIhNxe+U0q8EQzDR3ZGjEUzrJKc48ypa36PQVRO8LehB Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1jp820-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 15:15:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TFCcDx050577;
        Wed, 29 Jul 2020 15:13:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32hu5v1x8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 15:13:37 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06TFDaKQ024678;
        Wed, 29 Jul 2020 15:13:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 08:13:36 -0700
Date:   Wed, 29 Jul 2020 18:13:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, ebiggers@google.com,
        linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: Re: [PATCH 1/1] vt_ioctl: prevent VT_RESIZEX font height change from
 causing potential out-of-bounds access
Message-ID: <20200729151330.GE5493@kadam>
References: <1596026381-5013-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596026381-5013-1-git-send-email-george.kennedy@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:39:41AM -0400, George Kennedy wrote:
> Add a VT_RESIZEX check to ensure that changing the font height will not
> cause a potential out-of-bounds access. The candidate font height contained
> in "v_clin", though below the max, could still result in accesses beyond
> the allocated font data size.
> 
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
> ---
>  drivers/tty/vt/vt_ioctl.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index daf61c2..6185f1a 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -342,6 +342,9 @@ static void vt_disallocate_all(void)
>  	}
>  }
>  
> +/* from fbcon.c */
> +#define FNTSIZE(fd) (((int *)(fd))[-2])
> +#define FNTCHARCNT(fd) (((int *)(fd))[-3])

I really hate these macros.  I don't think we can actually use them here
without an out of bounds depending on the driver.

What happens is that:

con_font_set() allocates data:

	font.data = memdup_user(op->data, size);

Then it calls vc->vc_sw->con_font_set(vc, &font, op->flags);

Two of those function implementations newport_set_font() and
fbcon_set_font() make a new allocation, but with a secret extra buffer
to store extra data at the beginning.

  2645  static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
  2646                            unsigned int flags)
  2647  {
  2648          struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
  2649          unsigned charcount = font->charcount;
  2650          int w = font->width;
  2651          int h = font->height;
  2652          int size;
  2653          int i, csum;
  2654          u8 *new_data, *data = font->data;
  2655          int pitch = (font->width+7) >> 3;
  2656  
  2657          /* Is there a reason why fbconsole couldn't handle any charcount >256?
  2658           * If not this check should be changed to charcount < 256 */
  2659          if (charcount != 256 && charcount != 512)
  2660                  return -EINVAL;
  2661  
  2662          /* Make sure drawing engine can handle the font */
  2663          if (!(info->pixmap.blit_x & (1 << (font->width - 1))) ||
  2664              !(info->pixmap.blit_y & (1 << (font->height - 1))))
  2665                  return -EINVAL;
  2666  
  2667          /* Make sure driver can handle the font length */
  2668          if (fbcon_invalid_charcount(info, charcount))
  2669                  return -EINVAL;
  2670  
  2671          size = h * pitch * charcount;
  2672  
  2673          new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Extra space to store hidden data.

  2674  
  2675          if (!new_data)
  2676                  return -ENOMEM;
  2677  
  2678          new_data += FONT_EXTRA_WORDS * sizeof(int);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Hide the new data forever.

  2679          FNTSIZE(new_data) = size;
  2680          FNTCHARCNT(new_data) = charcount;
  2681          REFCOUNT(new_data) = 0; /* usage counter */
  2682          for (i=0; i< charcount; i++) {
  2683                  memcpy(new_data + i*h*pitch, data +  i*32*pitch, h*pitch);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Copy the user font data to the new buffer one element at a time?


  2684          }
  2685  
  2686          /* Since linux has a nice crc32 function use it for counting font
  2687           * checksums. */
  2688          csum = crc32(0, new_data, size);
  2689  

So only the two drivers with the secret extra buffer can use FNTSIZE()
and friends.

regards,
dan carpenter

