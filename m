Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4CCC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB10F2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="LrdIfbup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgD2L0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:26:40 -0400
Received: from out1.migadu.com ([91.121.223.63]:54796 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD2L0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:26:40 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 07:26:39 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=default;
        t=1588159147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imyH5i/2Y9yMNzm7UXaBN/+s9A++43Lu0do6gm4lZAo=;
        b=LrdIfbupDauYnhNB/LVW7socv26n2fC4hjUAyHuPXJNEkxTUwwClvoDTrPINu4HaMhyLgo
        2rAzNOU032gKGBlrYK/tFlmA75qh/N18BQ6tDUJLLelE+4b/sKqm4B7YwCj+vx8S6HsmSc
        AY1CCPyS+l3NPDGicr7OJQ8/QFbU5I0=
Date:   Wed, 29 Apr 2020 11:19:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   kl@kl.wtf
Message-ID: <e8d385dbfbbb09acfe58d716c588722c@kl.wtf>
Subject: Re: [PATCH v2] drm: make drm_file use keyed wakeups
To:     "Daniel Vetter" <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200428151410.GU3456981@phenom.ffwll.local>
References: <20200428151410.GU3456981@phenom.ffwll.local>
 <20200424162615.10461-1-kl@kl.wtf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

April 28, 2020 5:14 PM, "Daniel Vetter" <daniel@ffwll.ch> wrote:=0A=0A> O=
n Fri, Apr 24, 2020 at 06:26:15PM +0200, Kenny Levinsen wrote:=0A> =0A>> =
Some processes, such as systemd, are only polling for EPOLLERR|EPOLLHUP.=
=0A>> As drm_file uses unkeyed wakeups, such a poll can receive many spur=
ious=0A>> wakeups from uninteresting events if, for example, the file des=
cription=0A>> is subscribed to vblank events. This is the case with syste=
md, as it=0A>> polls a file description from logind that is shared with t=
he users'=0A>> compositor.=0A>> =0A>> Use keyed wakeups to allow the wake=
up target to more efficiently discard=0A>> these uninteresting events.=0A=
>> =0A>> Signed-off-by: Kenny Levinsen <kl@kl.wtf>=0A> =0A> Hm I applied =
v1 and I'm not spotting what's different here, and there's no=0A> changel=
og explaining what changed ...=0A> =0A> Please send a fixup if there's an=
ything important missing.=0A> -Daniel=0A>=0A=0AIt's only the summary that=
 differed as you and sravn requested in #dri-devel, so it's probably fine=
.=0A=0AI should have explained the change. I'm still trying to get the ha=
ng of the email-based workflow. :)=0A=0ABest regards,=0AKenny Levinsen=0A=
=0A>> ---=0A>> drivers/gpu/drm/drm_file.c | 6 ++++--=0A>> 1 file changed,=
 4 insertions(+), 2 deletions(-)=0A>> =0A>> diff --git a/drivers/gpu/drm/=
drm_file.c b/drivers/gpu/drm/drm_file.c=0A>> index c4c704e01961..ec25b3d9=
79d9 100644=0A>> --- a/drivers/gpu/drm/drm_file.c=0A>> +++ b/drivers/gpu/=
drm/drm_file.c=0A>> @@ -608,7 +608,8 @@ ssize_t drm_read(struct file *fil=
p, char __user *buffer,=0A>> file_priv->event_space -=3D length;=0A>> lis=
t_add(&e->link, &file_priv->event_list);=0A>> spin_unlock_irq(&dev->event=
_lock);=0A>> - wake_up_interruptible(&file_priv->event_wait);=0A>> + wake=
_up_interruptible_poll(&file_priv->event_wait,=0A>> + EPOLLIN | EPOLLRDNO=
RM);=0A>> break;=0A>> }=0A>> =0A>> @@ -804,7 +805,8 @@ void drm_send_even=
t_locked(struct drm_device *dev, struct drm_pending_event *e)=0A>> list_d=
el(&e->pending_link);=0A>> list_add_tail(&e->link,=0A>> &e->file_priv->ev=
ent_list);=0A>> - wake_up_interruptible(&e->file_priv->event_wait);=0A>> =
+ wake_up_interruptible_poll(&e->file_priv->event_wait,=0A>> + EPOLLIN | =
EPOLLRDNORM);=0A>> }=0A>> EXPORT_SYMBOL(drm_send_event_locked);=0A>> =0A>=
> --=0A>> 2.26.1=0A> =0A> --=0A> Daniel Vetter=0A> Software Engineer, Int=
el Corporation=0A> http://blog.ffwll.ch
